import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/screens/home.dart';
import 'package:writing_test/screens/students_list_page.dart';
import 'package:writing_test/screens/login.dart';

void main(){
  Future<void> performLogin(WidgetTester tester, String username, String password) async {
    var usernameWidget = find.widgetWithText(TextFormField, "username");
    var passwordWidget = find.widgetWithText(TextField, "password");

    await tester.enterText(usernameWidget, username);
    expect(find.text(username), findsOneWidget);

    await tester.enterText(passwordWidget, password);
    expect(find.text(password), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, "Giriş Yap"));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  }

  testWidgets("TextButton should navigated to ListPage", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    await performLogin(tester, "tugcekepen", "12345678");

    var textButton = find.byType(TextButton);

    await tester.tap(textButton);
    await tester.pumpAndSettle();

    expect(find.byType(StudentsListPage), findsOneWidget);
  });

  testWidgets("ListPage should be contain ListTiles", (tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    await performLogin(tester, "tugcekepen", "12345678");

    var textButton = find.byType(TextButton);

    await tester.tap(textButton);
    await tester.pumpAndSettle();

    expect(find.byType(StudentsListPage), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);
  });

  

}