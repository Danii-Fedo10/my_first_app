import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/main.dart';

void main() {
  testWidgets('Greeting, increment, and reset work', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Well to app'), findsOneWidget);
    expect(find.text('You tapped 0 times'), findsOneWidget);
    expect(find.text('Tap me'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);

    await tester.tap(find.text('Tap me'));
    await tester.pump();
    expect(find.text('You tapped 1 times'), findsOneWidget);

    await tester.tap(find.text('Reset'));
    await tester.pump();
    expect(find.text('You tapped 0 times'), findsOneWidget);
  });
}
