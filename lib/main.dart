import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const StudentsPage(),
    );
  }
}

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final students = [
      Student('Sara', [85, 72, 90, 64, 78]),
      Student('Daniel', [87, 92, 70, 94, 73]),
      Student('Ali', [60, 55, 70]),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(s.grade)),
              title: Text(s.name),
              subtitle: Text('Average: ${s.average.toStringAsFixed(1)}'),
            ),
          );
        },
      ),
    );
  }
}