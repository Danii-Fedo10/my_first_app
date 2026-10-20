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

  double get _classAverage {
    if (_students.isEmpty) return 0;
    return _students.map((student) => student.average).reduce((a, b) => a + b) /
        _students.length;
  }

  Color _gradeColor(String grade) {
    if (grade == 'A' || grade == 'B') return Colors.green;
    if (grade == 'C' || grade == 'D') return Colors.orange;
    return Colors.red;
  }

  Future<void> _addStudent() async {
    final result = await showDialog<_AddStudentResult>(
      context: context,
      builder: (context) => const _AddStudentDialog(),
    );

    if (result?.hasInvalidScores == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter at least one score')));
    }

    final student = result?.student;
    if (student != null && mounted) {
      setState(() {
        _students.add(student);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Class average: ${_classAverage.toStringAsFixed(1)}'),
          ),
          Expanded(
            child: ListView.builder(
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
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _students.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AddStudentDialog extends StatefulWidget {
  const _AddStudentDialog();

  @override
  State<_AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<_AddStudentDialog> {
  final _nameController = TextEditingController();
  final _scoresController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _scoresController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    final scores = _scoresController.text
        .split(',')
        .map((score) => int.tryParse(score.trim()))
        .whereType<int>()
        .toList();
    if (name.isEmpty) return;

    Navigator.pop(
      context,
      scores.isEmpty
          ? const _AddStudentResult.invalidScores()
          : _AddStudentResult.student(Student(name, scores)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add student'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _scoresController,
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
        ElevatedButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}

class _AddStudentResult {
  final Student? student;
  final bool hasInvalidScores;

  const _AddStudentResult.student(Student value)
    : student = value,
      hasInvalidScores = false;

  const _AddStudentResult.invalidScores()
    : student = null,
      hasInvalidScores = true;
}
