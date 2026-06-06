import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhang/src/library/data/seed_library_repository.dart';
import 'package:zhang/src/library/domain/library_models.dart';
import 'package:zhang/src/series/presentation/series_detail_screen.dart';

void main() {
  testWidgets('continue opens reader with injected repository pages', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SeriesDetailScreen(
          seriesId: _TestLibraryRepository.seriesId,
          repository: _TestLibraryRepository(),
        ),
      ),
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(find.text('1 / 3'), findsOneWidget);
    expect(find.text('Page 1'), findsOneWidget);
  });

  testWidgets('chapter tap opens reader for selected chapter', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SeriesDetailScreen(
          seriesId: _TestLibraryRepository.seriesId,
          repository: _TestLibraryRepository(),
        ),
      ),
    );

    await tester.tap(find.text('Chapter 8: Next Page'));
    await tester.pumpAndSettle();

    expect(find.text('1 / 2'), findsOneWidget);
    expect(find.text('Page 1'), findsOneWidget);
  });
}

class _TestLibraryRepository extends SeedLibraryRepository {
  static const seriesId = 'test-series-reader';

  static final _series = Series(
    id: seriesId,
    title: 'Reader Test Series',
    normalizedTitle: 'reader test series',
    author: 'A. Sora',
    artist: 'M. Kiri',
    description: 'A deterministic route into the reader.',
    coverPath: 'seed://covers/reader-test-series',
    categories: const ['Reading'],
    totalChapters: 2,
    readChapters: 0,
    lastReadAt: DateTime.utc(2026, 6, 5, 8),
  );

  @override
  Series? seriesById(String id) => id == seriesId ? _series : null;

  @override
  List<Chapter> chaptersForSeries(String seriesId) {
    if (seriesId != _TestLibraryRepository.seriesId) {
      return [];
    }

    return [
      Chapter(
        id: 'test-chapter-7',
        seriesId: seriesId,
        title: 'Chapter 7: Continue Here',
        number: 7,
        filePath: 'seed://reader-test-series/chapter-7.cbz',
        fileType: ChapterFileType.cbz,
        pageCount: 3,
        readProgressPage: 1,
        isRead: false,
        lastReadAt: DateTime.utc(2026, 6, 5, 8),
      ),
      Chapter(
        id: 'test-chapter-8',
        seriesId: seriesId,
        title: 'Chapter 8: Next Page',
        number: 8,
        filePath: 'seed://reader-test-series/chapter-8.cbz',
        fileType: ChapterFileType.cbz,
        pageCount: 2,
        readProgressPage: 0,
        isRead: false,
        lastReadAt: null,
      ),
    ];
  }

  @override
  List<ReaderPage> pagesForChapter(String chapterId) {
    final pageCount = chapterId == 'test-chapter-7' ? 3 : 2;

    return List.generate(
      pageCount,
      (index) => ReaderPage(
        id: '$chapterId-page-$index',
        chapterId: chapterId,
        index: index,
        sourcePath: 'seed://reader-test-series/$chapterId/page-$index',
        width: 1200,
        height: 1800,
        cachedImagePath: null,
      ),
    );
  }
}
