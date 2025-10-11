import 'package:flutter/material.dart';

/// Flutter code sample for [AppBar].

final List<int> _items = List<int>.generate(51, (int index) => index);

void main() => runApp(const AppBarApp());

class AppBarApp extends StatefulWidget {
  const AppBarApp({super.key});

  @override
  State<AppBarApp> createState() => _AppBarAppState();
}

class _AppBarAppState extends State<AppBarApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _onThemeSwitched(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff6750a4),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff6750a4),
        brightness: Brightness.dark,
      ),
      home: AppBarExample(
        isDarkMode: _themeMode == ThemeMode.dark,
        onThemeSwitched: _onThemeSwitched,
      ),
    );
  }
}

class AppBarExample extends StatefulWidget {
  const AppBarExample({
    super.key,
    required this.isDarkMode,
    required this.onThemeSwitched,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeSwitched;

  @override
  State<AppBarExample> createState() => _AppBarExampleState();
}

class _AppBarExampleState extends State<AppBarExample> {
  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
  final bool isDark = Theme.of(context).brightness == Brightness.dark;
  // Ajuste de colores según el modo
  final Color oddItemColor = isDark
    ? colorScheme.primary.withValues(alpha: 0.20)
    : colorScheme.primary.withValues(alpha: 0.05);
  final Color evenItemColor = isDark
    ? colorScheme.primary.withValues(alpha: 0.30)
    : colorScheme.primary.withValues(alpha: 0.15);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Demo'),
        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
      ),
      body: GridView.builder(
        itemCount: _items.length,
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Center(
              child: Text(
                'Scroll to see the Appbar in effect.',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            );
          }
          return Container(
            alignment: Alignment.center,
            // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: _items[index].isOdd ? oddItemColor : evenItemColor,
            ),
            child: Text('Item $index'),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            overflowSpacing: 5.0,
            children: <Widget>[
              // Switch de tema claro/oscuro
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.dark_mode),
                  const SizedBox(width: 8),
                  Switch.adaptive(
                    value: widget.isDarkMode,
                    onChanged: widget.onThemeSwitched,
                  ),
                  const SizedBox(width: 8),
                  Text(widget.isDarkMode ? 'Modo oscuro' : 'Modo claro'),
                ],
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    shadowColor = !shadowColor;
                  });
                },
                icon: Icon(shadowColor ? Icons.visibility_off : Icons.visibility),
                label: const Text('shadow color'),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  if (scrolledUnderElevation == null) {
                    setState(() {
                      // Default elevation is 3.0, increment by 1.0.
                      scrolledUnderElevation = 4.0;
                    });
                  } else {
                    setState(() {
                      scrolledUnderElevation = scrolledUnderElevation! + 1.0;
                    });
                  }
                },
                child: Text('scrolledUnderElevation: ${scrolledUnderElevation ?? 'default'}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}