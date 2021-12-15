// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_tests_example/main.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens(
    'My home page',
    (tester) async {
      // Builds the given scenario within a device wrapper
      final builder = DeviceBuilder()
        ..addScenario(
          name: 'Initial Page',
          widget: const MyHomePage(
            title: 'My Home Page',
          ),
        )
        ..addScenario(
          name: 'Tapped Once Page',
          widget: const MyHomePage(
            title: 'My Home Page',
          ),
          onCreate: (key) async {
            final finder = find.descendant(
              of: find.byKey(key),
              matching: find.byIcon(Icons.add),
            );
            expect(finder, findsOneWidget);

            await tester.tap(finder);
          },
        );

      await tester.pumpDeviceBuilder(
        builder,
        wrapper: materialAppWrapper(
          theme: ThemeData(primaryColor: Colors.red),
        ),
      );

      await screenMatchesGolden(tester, 'my_home_page');
    },
  );
}
