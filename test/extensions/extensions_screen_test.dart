import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhang/src/extensions/domain/extension_models.dart';
import 'package:zhang/src/extensions/presentation/extensions_screen.dart';

void main() {
  testWidgets('android extensions screen shows android-only manager', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: ExtensionsScreen(platform: AppPlatform.android)),
    );

    expect(find.text('Local Files'), findsOneWidget);
    expect(find.text('Android Extension Packages'), findsOneWidget);
    expect(find.textContaining('Install source: android-only'), findsOneWidget);
  });

  testWidgets('ios extensions screen explains bundled connector rule', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: ExtensionsScreen(platform: AppPlatform.ios)),
    );

    expect(find.text('Local Files'), findsOneWidget);
    expect(find.text('Android Extension Packages'), findsNothing);
    expect(
      find.textContaining('iOS uses bundled or reviewed connectors'),
      findsOneWidget,
    );
  });

  testWidgets('bundled extension switches can be toggled locally', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: ExtensionsScreen(platform: AppPlatform.android)),
    );

    final localFilesSwitch = find.byType(Switch).first;

    expect(tester.widget<Switch>(localFilesSwitch).value, isTrue);

    await tester.tap(localFilesSwitch);
    await tester.pumpAndSettle();

    expect(tester.widget<Switch>(localFilesSwitch).value, isFalse);
  });
}
