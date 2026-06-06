import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhang/src/library/data/seed_library_repository.dart';
import 'package:zhang/src/library/domain/library_models.dart';
import 'package:zhang/src/library/presentation/library_screen.dart';

void main() {
  testWidgets('library shows seed series and reading progress', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LibraryScreen()));

    expect(find.text('Moonlit Atlas'), findsOneWidget);
    expect(find.text('12 / 18'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text('Iron Plum'), findsOneWidget);
    expect(find.text('Rain Index'), findsOneWidget);
  });

  testWidgets('search action is disabled until search exists', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LibraryScreen()));

    final searchButton = tester.widget<IconButton>(find.byType(IconButton));

    expect(searchButton.onPressed, isNull);
  });

  testWidgets('opens selected series detail with active repository', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: LibraryScreen(repository: _TestLibraryRepository())),
    );

    await tester.ensureVisible(find.text('Moonlit Atlas'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Moonlit Atlas'));
    await tester.pumpAndSettle();

    expect(find.text('Chapters'), findsOneWidget);
    expect(find.text('Chapter 12: The Red Gate'), findsOneWidget);

    final continueButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Continue'),
    );

    expect(continueButton.onPressed, isNotNull);
  });
}

class _TestLibraryRepository extends SeedLibraryRepository {
  static final _series = Series(
    id: 'test-moonlit-atlas',
    title: 'Moonlit Atlas',
    normalizedTitle: 'moonlit atlas',
    author: 'A. Sora',
    artist: 'M. Kiri',
    description: 'A test-only moonlit route.',
    coverPath: 'seed://covers/test-moonlit-atlas',
    categories: const ['Reading', 'Fantasy'],
    totalChapters: 18,
    readChapters: 12,
    lastReadAt: DateTime.utc(2026, 6, 5, 8),
  );

  @override
  List<Series> watchSeries() => [_series];

  @override
  Series? seriesById(String id) => id == _series.id ? _series : null;

  @override
  List<Chapter> chaptersForSeries(String seriesId) {
    if (seriesId != _series.id) {
      return [];
    }

    return [
      Chapter(
        id: 'test-chapter-moonlit-12',
        seriesId: _series.id,
        title: 'Chapter 12: The Red Gate',
        number: 12,
        filePath: 'seed://test-moonlit-atlas/chapter-12.cbz',
        fileType: ChapterFileType.cbz,
        pageCount: 34,
        readProgressPage: 14,
        isRead: false,
        lastReadAt: DateTime.utc(2026, 6, 5, 8),
      ),
    ];
  }
}
