enum ChapterFileType { cbz, zip, pdf, imageFolder, source }

enum ReaderMode { singlePage, doublePage, verticalScroll }

enum ReadingDirection { leftToRight, rightToLeft }

class Series {
  const Series({
    required this.id,
    required this.title,
    required this.normalizedTitle,
    required this.author,
    required this.artist,
    required this.description,
    required this.coverPath,
    required this.categories,
    required this.totalChapters,
    required this.readChapters,
    required this.lastReadAt,
  });

  final String id;
  final String title;
  final String normalizedTitle;
  final String author;
  final String artist;
  final String description;
  final String coverPath;
  final List<String> categories;
  final int totalChapters;
  final int readChapters;
  final DateTime? lastReadAt;

  int get unreadCount => totalChapters - readChapters;
  String get progressLabel => '$readChapters / $totalChapters';
}

class Chapter {
  const Chapter({
    required this.id,
    required this.seriesId,
    required this.title,
    required this.number,
    required this.filePath,
    required this.fileType,
    required this.pageCount,
    required this.readProgressPage,
    required this.isRead,
    required this.lastReadAt,
  });

  final String id;
  final String seriesId;
  final String title;
  final double number;
  final String filePath;
  final ChapterFileType fileType;
  final int pageCount;
  final int readProgressPage;
  final bool isRead;
  final DateTime? lastReadAt;

  bool get isStarted => readProgressPage > 0 && !isRead;
}

class ReaderPage {
  const ReaderPage({
    required this.id,
    required this.chapterId,
    required this.index,
    required this.sourcePath,
    required this.width,
    required this.height,
    required this.cachedImagePath,
  });

  final String id;
  final String chapterId;
  final int index;
  final String sourcePath;
  final int width;
  final int height;
  final String? cachedImagePath;
}

class Bookmark {
  const Bookmark({
    required this.id,
    required this.chapterId,
    required this.pageIndex,
    required this.note,
    required this.createdAt,
  });

  final String id;
  final String chapterId;
  final int pageIndex;
  final String note;
  final DateTime createdAt;
}
