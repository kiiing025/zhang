import '../domain/library_models.dart';

class SeedLibraryRepository {
  final List<Series> _series = [
    Series(
      id: 'series-moonlit-atlas',
      title: 'Moonlit Atlas',
      normalizedTitle: 'moonlit atlas',
      author: 'A. Sora',
      artist: 'M. Kiri',
      description:
          'A cartographer finds a city that only appears by moonlight.',
      coverPath: 'seed://covers/moonlit-atlas',
      categories: const ['Reading', 'Fantasy'],
      totalChapters: 18,
      readChapters: 12,
      lastReadAt: DateTime.utc(2026, 6, 5, 8),
    ),
    const Series(
      id: 'series-iron-plum',
      title: 'Iron Plum',
      normalizedTitle: 'iron plum',
      author: 'Ren Hoshino',
      artist: 'Ren Hoshino',
      description: 'A quiet martial artist inherits a mechanical orchard.',
      coverPath: 'seed://covers/iron-plum',
      categories: ['Unread', 'Action'],
      totalChapters: 9,
      readChapters: 0,
      lastReadAt: null,
    ),
    Series(
      id: 'series-rain-index',
      title: 'Rain Index',
      normalizedTitle: 'rain index',
      author: 'Lia Park',
      artist: 'Jun Vale',
      description: 'Every storm records a secret in the city archive.',
      coverPath: 'seed://covers/rain-index',
      categories: const ['Complete', 'Mystery'],
      totalChapters: 24,
      readChapters: 24,
      lastReadAt: DateTime.utc(2026, 5, 28, 21),
    ),
  ];

  final Map<String, List<Chapter>> _chaptersBySeries = {
    'series-moonlit-atlas': [
      Chapter(
        id: 'chapter-moonlit-12',
        seriesId: 'series-moonlit-atlas',
        title: 'Chapter 12: The Red Gate',
        number: 12,
        filePath: 'seed://moonlit-atlas/chapter-12.cbz',
        fileType: ChapterFileType.cbz,
        pageCount: 34,
        readProgressPage: 14,
        isRead: false,
        lastReadAt: DateTime.utc(2026, 6, 5, 8),
      ),
      const Chapter(
        id: 'chapter-moonlit-13',
        seriesId: 'series-moonlit-atlas',
        title: 'Chapter 13: Ink Compass',
        number: 13,
        filePath: 'seed://moonlit-atlas/chapter-13.cbz',
        fileType: ChapterFileType.cbz,
        pageCount: 31,
        readProgressPage: 0,
        isRead: false,
        lastReadAt: null,
      ),
    ],
    'series-iron-plum': [
      const Chapter(
        id: 'chapter-iron-1',
        seriesId: 'series-iron-plum',
        title: 'Chapter 1: Orchard Key',
        number: 1,
        filePath: 'seed://iron-plum/chapter-1.zip',
        fileType: ChapterFileType.zip,
        pageCount: 28,
        readProgressPage: 0,
        isRead: false,
        lastReadAt: null,
      ),
    ],
    'series-rain-index': [
      Chapter(
        id: 'chapter-rain-24',
        seriesId: 'series-rain-index',
        title: 'Chapter 24: Clear Weather',
        number: 24,
        filePath: 'seed://rain-index/chapter-24.pdf',
        fileType: ChapterFileType.pdf,
        pageCount: 42,
        readProgressPage: 42,
        isRead: true,
        lastReadAt: DateTime.utc(2026, 5, 28, 21),
      ),
    ],
  };

  List<Series> watchSeries() {
    final sorted = [..._series];
    sorted.sort((a, b) {
      final aDate = a.lastReadAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.lastReadAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });
    return sorted;
  }

  Series? seriesById(String id) {
    for (final series in _series) {
      if (series.id == id) {
        return series;
      }
    }
    return null;
  }

  List<Chapter> chaptersForSeries(String seriesId) {
    return [...?_chaptersBySeries[seriesId]]
      ..sort((a, b) => a.number.compareTo(b.number));
  }

  Chapter? continueChapter(String seriesId) {
    final chapters = chaptersForSeries(seriesId);
    for (final chapter in chapters) {
      if (chapter.isStarted) {
        return chapter;
      }
    }
    for (final chapter in chapters) {
      if (!chapter.isRead) {
        return chapter;
      }
    }
    return chapters.isEmpty ? null : chapters.last;
  }

  List<ReaderPage> pagesForChapter(String chapterId) {
    return List.generate(
      3,
      (index) => ReaderPage(
        id: '$chapterId-page-$index',
        chapterId: chapterId,
        index: index,
        sourcePath:
            'seed://moonlit-atlas/chapter-12/page-${(index + 1).toString().padLeft(3, '0')}',
        width: 1200,
        height: 1800,
        cachedImagePath: null,
      ),
    );
  }
}
