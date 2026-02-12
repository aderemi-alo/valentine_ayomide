import 'package:flutter_test/flutter_test.dart';

import 'package:valentine_ayomide/main.dart';

void main() {
  testWidgets('renders cover and jump controls', (WidgetTester tester) async {
    await tester.pumpWidget(const ValentinePlaybookApp());

    expect(find.text('Our Love\nStory'), findsOneWidget);
    expect(find.text('Cover'), findsOneWidget);
    expect(find.text('Contents'), findsOneWidget);
    expect(find.text('Our Story'), findsOneWidget);
    expect(find.text('Letter'), findsOneWidget);
  });
}
