import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/login.dart';

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

  // testWidgets("Username field must be filled", (widgetTester) async {
  //   await widgetTester.pumpWidget(MaterialApp(home: LoginPage(),));
  //   await widgetTester.tap(find.byType(ElevatedButton));



  // });
}
