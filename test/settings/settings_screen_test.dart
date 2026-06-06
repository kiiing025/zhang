import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhang/src/settings/presentation/settings_screen.dart';

void main() {
  testWidgets('theme setting updates value and notifies app shell', (
    tester,
  ) async {
    ThemeMode? selectedThemeMode;

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsScreen(
          onThemeModeChanged: (mode) => selectedThemeMode = mode,
        ),
      ),
    );

    await tester.tap(find.text('Theme'));
    await tester.pumpAndSettle();

    expect(find.text('Choose theme'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(find.text('Choose theme'), findsNothing);
    expect(find.text('Dark'), findsOneWidget);
    expect(selectedThemeMode, ThemeMode.dark);
  });

  testWidgets('reader settings update selected values', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    await tester.tap(find.text('Default reader mode'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Vertical scroll'));
    await tester.pumpAndSettle();

    expect(find.text('Vertical scroll'), findsOneWidget);

    await tester.tap(find.text('Reading direction'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Left to right'));
    await tester.pumpAndSettle();

    expect(find.text('Left to right'), findsOneWidget);
  });

  testWidgets('extension behavior and content note show dialogs', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    await tester.tap(find.text('Extension behavior'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Strict bundled only'));
    await tester.pumpAndSettle();

    expect(find.text('Strict bundled only'), findsOneWidget);

    await tester.tap(find.text('Content note'));
    await tester.pumpAndSettle();

    expect(find.text('Authorized content only'), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(find.text('Authorized content only'), findsNothing);
  });
}
