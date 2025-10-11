import 'package:flutter/material.dart';

// Reusable gradient: black -> fuchsia
const LinearGradient appGradient = LinearGradient(
  colors: [Colors.black, Colors.pinkAccent],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppBar Demo',
      debugShowCheckedModeBanner: false, // 🔹 quita la etiqueta "DEBUG"
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0), // 🔹 color principal de la app
          brightness: Brightness.light, // 🔹 modo claro
        ),
        useMaterial3: true, // 🔹 diseño Material 3 (más moderno)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // 🔹 AppBar transparente
          foregroundColor: Colors.white, // 🔹 texto e íconos blancos
          elevation: 3, // 🔹 pequeña sombra debajo del AppBar
          centerTitle: false,
        ),
      ),
      home: const AppBarExample(),
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: appGradient),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu',
          onPressed: () {},
        ),
        title: const Text('AppBar Demo'),
        actions: <Widget>[
          // 🔔 Botón 1: muestra SnackBar
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  content: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      gradient: appGradient,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Text(
                      '¿Pan con chicharrón vende?',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // ➡️ Botón 2: navega a otra página
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const NextPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: const Center(
          child: Text(
            'This is the home page',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: appGradient),
        ),
        title: const Text('Next page'),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: const Center(
          child: Text(
            'This is the next page',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
