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

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final List<Student> _students = [
    Student('Sara', [85, 72, 90, 64, 78]),
    Student('Daniel', [87, 92, 70, 94, 73]),
    Student('Ali', [60, 55, 70]),
  ];

  Color _gradeColor(String grade) {
    if (grade == 'A' || grade == 'B') return Colors.green;
    if (grade == 'C' || grade == 'D') return Colors.orange;
    return Colors.red;
  }

  Future<void> _addStudent() async {
    final nameController = TextEditingController();
    final scoresController = TextEditingController();

    final result = await showDialog<Student>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: scoresController,
              decoration: const InputDecoration(
                labelText: 'Scores (example: 80, 90, 75)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final scores = scoresController.text
                  .split(',')
                  .map((e) => int.tryParse(e.trim()))
                  .whereType<int>()
                  .toList();
              if (name.isEmpty) return;
              Navigator.pop(context, Student(name, scores));
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _students.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudent,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final s = _students[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _gradeColor(s.grade),
                child: Text(s.grade),
              ),
              title: Text(s.name),
              subtitle: Text('Average: ${s.average.toStringAsFixed(1)}'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You tapped ${s.name}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}