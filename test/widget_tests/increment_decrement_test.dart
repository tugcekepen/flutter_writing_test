import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/pages/home.dart';
import 'package:writing_test/pages/login.dart';
import 'package:writing_test/main.dart';

void main() {
  testWidgets('Counter Increment and Decrement Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(LoginPage));
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(2));

      var username = find.widgetWithText(TextFormField, "username");
      var password = find.widgetWithText(TextField, "password");

      await tester.enterText(username, "tugcekepen");

      expect(find.text("tugcekepen"), findsOneWidget);

      await tester.enterText(password, "12345678");

      expect(find.text("12345678"), findsOneWidget);

      await tester
          .tap(find.widgetWithText(ElevatedButton, "Giriş Yap"));

      await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.exposure_plus_1));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}