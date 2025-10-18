import 'package:flutter/material.dart';

/// Flutter code sample for [AppBar] with dynamic color, SnackBar, and Switch.

final List<int> _items = List<int>.generate(51, (int index) => index);

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: const Color(0xff00BCD4)),
      debugShowCheckedModeBanner: false, // Añadido para quitar el banner de debug
      home: const AppBarExample(),
    );
  }
}

class AppBarExample extends StatefulWidget {
  const AppBarExample({super.key});

  @override
  State<AppBarExample> createState() => _AppBarExampleState();
}

class _AppBarExampleState extends State<AppBarExample> {
  bool shadowColor = false;
  double? scrolledUnderElevation;
  Color appBarColor = Colors.blue;
  Color scaffoldBackgroundColor = Colors.grey[200]!;
  final List<Color> _appBarColors = [Colors.blue, const Color.fromARGB(255, 129, 175, 76), Colors.red, Colors.purple, const Color.fromARGB(255, 179, 121, 34)];
  final List<Color> _scaffoldColors = [Colors.grey[200]!, Colors.lightGreen[200]!, Colors.pink[200]!, Colors.teal[200]!, Colors.amber[200]!];
  int _currentAppBarColorIndex = 0;
  int _currentScaffoldColorIndex = 0;

  void _changeAppBarColor(int newIndex, bool isAppBar) {
    setState(() {
      if (isAppBar) {
        _currentAppBarColorIndex = newIndex;
        appBarColor = _appBarColors[_currentAppBarColorIndex];
      } else {
        _currentScaffoldColorIndex = newIndex;
        scaffoldBackgroundColor = _scaffoldColors[_currentScaffoldColorIndex];
      }
    });
  }

  void _showElevationSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('scrolledUnderElevation: ${scrolledUnderElevation ?? 'default'}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('AppBar Demo'),
        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
        backgroundColor: appBarColor,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.color_lens),
            tooltip: 'Change AppBar Color',
            onSelected: (int newIndex) => _changeAppBarColor(newIndex, true),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Blue'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Green'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Red'),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text('Purple'),
              ),
              const PopupMenuItem<int>(
                value: 4,
                child: Text('Orange'),
              ),
            ],
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.format_paint),
            tooltip: 'Change Background Color',
            onSelected: (int newIndex) => _changeAppBarColor(newIndex, false),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Grey'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Light Green'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Pink'),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text('Teal'),
              ),
              const PopupMenuItem<int>(
                value: 4,
                child: Text('Amber'),
              ),
            ],
          ),
        ],
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: _items[index].isOdd ? oddItemColor : evenItemColor,
              border: Border.all(color: Colors.pink, width: 1),
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
              IconButton(
                icon: Icon(shadowColor ? Icons.lightbulb : Icons.lightbulb_outline),
                tooltip: 'Toggle Shadow',
                color: Colors.pink,
                onPressed: () {
                  setState(() {
                    shadowColor = !shadowColor;
                  });
                },
              ),
              const SizedBox(width: 5),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (scrolledUnderElevation == null) {
                      scrolledUnderElevation = 4.0;
                    } else {
                      scrolledUnderElevation = scrolledUnderElevation! + 1.0;
                    }
                    _showElevationSnackBar();
                  });
                },
                icon: const Icon(Icons.layers),
                label: Text('Elevation: ${scrolledUnderElevation ?? 'default'}'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
