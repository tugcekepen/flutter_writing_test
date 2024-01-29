import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/main.dart';

void main() {
  testWidgets('Counter Increment and Decrement Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.exposure_plus_1));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.exposure_minus_1));
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
  });
}