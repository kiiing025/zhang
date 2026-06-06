import 'package:flutter_test/flutter_test.dart';
import 'package:zhang/src/library/data/seed_library_repository.dart';
import 'package:zhang/src/library/domain/library_models.dart';

void main() {
  test('seed library contains readable series ordered by recent activity', () {
    final repository = SeedLibraryRepository();

    final series = repository.watchSeries();

    expect(series, hasLength(3));
    expect(series.first.title, 'Moonlit Atlas');
    expect(series.first.progressLabel, '12 / 18');
    expect(series.first.unreadCount, 6);
  });

  test('continueChapter returns the first in-progress chapter', () {
    final repository = SeedLibraryRepository();
    final series = repository.watchSeries().first;

    final chapter = repository.continueChapter(series.id);

    expect(chapter?.title, 'Chapter 12: The Red Gate');
    expect(chapter?.readProgressPage, 14);
  });

  test('reader pages are stable and sorted by index', () {
    final repository = SeedLibraryRepository();
    final series = repository.watchSeries().first;
    final chapter = repository.continueChapter(series.id)!;

    final pages = repository.pagesForChapter(chapter.id);

    expect(pages.map((page) => page.index), [0, 1, 2]);
    expect(pages.first.sourcePath, 'seed://moonlit-atlas/chapter-12/page-001');
    expect(chapter.fileType, ChapterFileType.cbz);
  });
}
