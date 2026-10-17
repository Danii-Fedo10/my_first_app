import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _taps = 0;

  void _increase() {
    setState(() {
      _taps++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daniel's First App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hello, Daniel!', style: TextStyle(fontSize: 28)),
            const SizedBox(height: 16),
            Text('You tapped $_taps times'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _increase,
              child: const Text('Tap me'),
            ),
          ],
        ),
      ),
    );
  }
}