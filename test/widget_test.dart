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
    expect(find.text('Class average: 74.2'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(3));

    final middleGradeAvatar = tester.widget<CircleAvatar>(
      find.widgetWithText(CircleAvatar, 'D'),
    );
    expect(middleGradeAvatar.backgroundColor, Colors.orange);

    final passingGradeAvatar = tester.widget<CircleAvatar>(
      find.widgetWithText(CircleAvatar, 'B'),
    );
    expect(passingGradeAvatar.backgroundColor, Colors.green);

    await tester.tap(find.text('Sara'));
    await tester.pump();
    expect(find.text('You tapped Sara'), findsOneWidget);
  });

  testWidgets('Students can be deleted and class average updates', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    expect(find.text('Sara'), findsNothing);
    expect(find.text('Class average: 72.4'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('Adding a student without valid scores shows a SnackBar', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Maya');
    await tester.enterText(find.byType(TextField).last, 'abc, , -');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Enter at least one score'), findsOneWidget);
    expect(find.text('Maya'), findsNothing);
  });
}
