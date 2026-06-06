import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhang/src/app/zhang_app.dart';
import 'package:zhang/src/extensions/domain/extension_models.dart';

void main() {
  testWidgets('shows the four foundation tabs', (tester) async {
    await tester.pumpWidget(const ZhangApp());

    expect(find.text('Library'), findsWidgets);
    expect(find.text('Extensions'), findsOneWidget);
    expect(find.text('Import'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('章'), findsOneWidget);
  });

  testWidgets('passes ios platform to extensions tab', (tester) async {
    await tester.pumpWidget(const ZhangApp(platform: AppPlatform.ios));

    await tester.tap(find.text('Extensions'));
    await tester.pumpAndSettle();

    expect(find.text('Android Extension Packages'), findsNothing);
    expect(
      find.textContaining('iOS uses bundled or reviewed connectors'),
      findsOneWidget,
    );
  });

  testWidgets('defaults to ios extension guardrails on ios target', (
    tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await tester.pumpWidget(const ZhangApp());

      await tester.tap(find.text('Extensions'));
      await tester.pumpAndSettle();

      expect(find.text('Android Extension Packages'), findsNothing);
      expect(
        find.textContaining('iOS uses bundled or reviewed connectors'),
        findsOneWidget,
      );
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('import and settings tabs show foundation content', (
    tester,
  ) async {
    await tester.pumpWidget(const ZhangApp());

    await tester.tap(find.text('Import'));
    await tester.pumpAndSettle();

    expect(find.text('Choose files'), findsOneWidget);
    expect(find.text('Choose folder'), findsOneWidget);
    expect(find.text('Planned formats'), findsOneWidget);
    expect(
      find.text('CBZ, ZIP, PDF, and image folders selected by the user.'),
      findsOneWidget,
    );
    expect(find.text('No files scanned yet'), findsOneWidget);

    final chooseFilesButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Choose files'),
    );
    final chooseFolderButton = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Choose folder'),
    );

    expect(chooseFilesButton.onPressed, isNull);
    expect(chooseFolderButton.onPressed, isNull);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Theme'), findsOneWidget);
    expect(find.text('System'), findsOneWidget);
    expect(find.text('Default reader mode'), findsOneWidget);
    expect(find.text('Single page'), findsOneWidget);
    expect(find.text('Reading direction'), findsOneWidget);
    expect(find.text('Right to left'), findsOneWidget);
    expect(find.text('Extension behavior'), findsOneWidget);
    expect(
      find.text('Bundled connectors on iOS, signed packages later on Android'),
      findsOneWidget,
    );
    expect(find.text('Content note'), findsOneWidget);
    expect(
      find.text(
        'Zh\u0101ng is for user-owned, self-hosted, open-license, or authorized content.',
      ),
      findsOneWidget,
    );
  });
}
