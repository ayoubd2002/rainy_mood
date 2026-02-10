// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:rainy_app/main.dart';
import 'package:rainy_app/injection_container.dart' as di;

void main() {
  setUpAll(() async {
    await di.init();
  });

  testWidgets('RainFocus app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RainFocusApp());

    // Verify that the app title is displayed
    expect(find.text('RainFocus'), findsOneWidget);
    expect(find.text('Ambient rain sounds for focus'), findsOneWidget);
  });
}
