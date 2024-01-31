import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/login.dart';
import 'package:writing_test/main.dart';

void main() {
  group('Username and Password', () {
    testWidgets('LoginPage widget should contain username field',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byType(TextFormField), findsWidgets);
      expect(find.text('username'), findsOneWidget);
    });

    testWidgets('LoginPage widget should contain password field',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
      ));

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('password'), findsOneWidget);
    });
  });

  group("The fields cannot be left blank", () {
    testWidgets("'Giriş Yap' button cannot navigate to MyHomePage if text fields are empty", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      expect(find.byType(ElevatedButton), findsOneWidget);

      // Metin alanlarının kontrolü
      var usernameField = find.widgetWithText(TextFormField, "username");
      var passwordField = find.widgetWithText(TextFormField, "password");

      var usernameEmpty = (tester.widget<TextFormField>(usernameField).controller?.text.isEmpty);
      var passwordEmpty = (tester.widget<TextFormField>(passwordField).controller?.text.isEmpty);
      
      await tester.tap(find.widgetWithText(ElevatedButton, "Giriş Yap"));

      await tester.pumpAndSettle(); // Ekran geçişini bekle
      
      if (usernameEmpty! || passwordEmpty!) {
        expect(find.text("Hata"), findsOneWidget);
      } else {
        expect(find.byType(MyHomePage), findsOneWidget);
      }
    });

    testWidgets("The 'Giriş Yap' button should go to MyHomePage",
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: LoginPage()));

      expect(find.byType(TextFormField), findsNWidgets(2));

      var username = find.widgetWithText(TextFormField, "username");
      var password = find.widgetWithText(TextField, "password");

      await widgetTester.enterText(username, "tugcekepen");

      expect(find.text("tugcekepen"), findsOneWidget);

      await widgetTester.enterText(password, "12345678");

      expect(find.text("12345678"), findsOneWidget);

      await widgetTester
          .tap(find.widgetWithText(ElevatedButton, "Giriş Yap"));

      await widgetTester.pumpAndSettle();

      expect(find.byType(MyHomePage), findsOneWidget);
      expect(find.text("0"), findsOneWidget);
    });
  });
}
