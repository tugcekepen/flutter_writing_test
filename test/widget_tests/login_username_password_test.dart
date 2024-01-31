import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/pages/home.dart';
import 'package:writing_test/pages/login.dart';

void main() {
  setUp(() => null);
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
      
      await tester.tap(find.widgetWithText(ElevatedButton, "Giriş Yap"));

      await tester.pumpAndSettle(); // Ekran geçişini bekle
      
      expect(find.text("Hata"), findsOneWidget);
    });

    testWidgets("'Giriş Yap' button cannot navigate to MyHomePage if even a single field is empty - 1", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      expect(find.byType(TextFormField), findsNWidgets(2));

      var username = find.widgetWithText(TextFormField, "username");

      await tester.enterText(username, "tugcekepen");

      expect(find.text("tugcekepen"), findsOneWidget);

      await tester
          .tap(find.widgetWithText(ElevatedButton, "Giriş Yap"));

      await tester.pumpAndSettle();

      expect(find.text("Hata"), findsOneWidget);
    });

    testWidgets("'Giriş Yap' button cannot navigate to MyHomePage if even a single field is empty - 2", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      expect(find.byType(TextFormField), findsNWidgets(2));

      var username = find.widgetWithText(TextFormField, "password");

      await tester.enterText(username, "12345678");

      expect(find.text("12345678"), findsOneWidget);

      await tester
          .tap(find.widgetWithText(ElevatedButton, "Giriş Yap"));

      await tester.pumpAndSettle();

      expect(find.text("Hata"), findsOneWidget);
    });

    testWidgets("The 'Giriş Yap' button should go to MyHomePage",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

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
      expect(find.text("0"), findsOneWidget);
    });
  });

  group("Wrong datas", () { 
    testWidgets("If the correct data is not entered, login cannot be made - username", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      expect(find.byType(TextFormField), findsNWidgets(2));

      var username = find.widgetWithText(TextFormField, "username");
      var password = find.widgetWithText(TextField, "password");

      await tester.enterText(username, "fatmainan"); //false input

      expect(find.text("fatmainan"), findsOneWidget);

      await tester.enterText(password, "12345678"); //true input

      expect(find.text("12345678"), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, "Giriş Yap"));
      await tester.pumpAndSettle();

      expect(find.text("Hata"), findsOneWidget);
    });

    testWidgets("If the correct data is not entered, login cannot be made - password", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      expect(find.byType(TextFormField), findsNWidgets(2));

      var username = find.widgetWithText(TextFormField, "username");
      var password = find.widgetWithText(TextField, "password");

      await tester.enterText(username, "zaferdag"); //true input

      expect(find.text("zaferdag"), findsOneWidget);

      await tester.enterText(password, "88888888"); //false input

      expect(find.text("88888888"), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, "Giriş Yap"));
      await tester.pumpAndSettle();

      expect(find.text("Hata"), findsOneWidget);
    });
  });

  

}
