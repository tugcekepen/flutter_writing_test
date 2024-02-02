import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/pages/home.dart';
import 'package:writing_test/pages/students_list_page.dart';
import 'package:writing_test/pages/login.dart';

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

  Future<void> pushToListPage(WidgetTester tester ) async {
    var textButton = find.byType(TextButton);

    await tester.tap(textButton);
    await tester.pumpAndSettle();

    expect(find.byType(StudentsListPage), findsOneWidget);
  }

  Future<void> listPageButton(WidgetTester tester, Finder finder) async {
    expect(finder, findsOneWidget);

    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  group("back icons from page to page", () {
    testWidgets("LoginPage <- HomePage", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage(),));
      await performLogin(tester, "aliyilmaz", "12345678");

      var backIcon = find.byKey(const Key("home_page_back"));

      await listPageButton(tester, backIcon);

      expect(find.text("0"), findsNothing);
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets("HomePage <- ListPage", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      await performLogin(tester, "aliyilmaz", "12345678");
      await pushToListPage(tester);

      var backIcon = find.byKey(const Key("list_page_back"));

      await listPageButton(tester, backIcon);

      expect(find.byType(ListTile), findsNothing);
      expect(find.byType(HomePage), findsOneWidget);
    });
  });


  
}