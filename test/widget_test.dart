import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/main.dart';
import 'package:my_first_app/student.dart';

void main() {
  test('Student average and grade are calculated', () {
    final s = Student('Sara', [85, 72, 90, 64, 78]);
    expect(s.average.toStringAsFixed(1), '77.8');
    expect(s.grade, 'C');
  });

  test('Scores averaging at 90 receive an A', () {
    final student = Student('Test', [95, 92]);
    expect(student.grade, 'A');
  });

  test('Empty scores give average 0 and grade F', () {
    final s = Student('Nobody', []);
    expect(s.average, 0);
    expect(s.grade, 'F');
  });

  testWidgets('Students page shows names and averages', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Sara'), findsOneWidget);
    expect(find.text('Average: 77.8'), findsOneWidget);
    expect(find.text('Daniel'), findsOneWidget);
    expect(find.text('Ali'), findsOneWidget);
    expect(find.text('Maya'), findsOneWidget);
    expect(find.text('Leo'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(5));

    final failingGradeAvatar = tester.widget<CircleAvatar>(
      find.widgetWithText(CircleAvatar, 'F'),
    );
    expect(failingGradeAvatar.backgroundColor, Colors.red);

    final passingGradeAvatar = tester.widget<CircleAvatar>(
      find.widgetWithText(CircleAvatar, 'A'),
    );
    expect(passingGradeAvatar.backgroundColor, Colors.green);

    await tester.tap(find.text('Leo'));
    await tester.pump();
    expect(find.text('Leo'), findsNWidgets(2));
  });
}
