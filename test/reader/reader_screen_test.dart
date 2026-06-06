import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhang/src/library/data/seed_library_repository.dart';
import 'package:zhang/src/library/domain/library_models.dart';
import 'package:zhang/src/reader/presentation/reader_screen.dart';

void main() {
  testWidgets('shows an empty state when chapter has no pages', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ReaderScreen(
          chapterId: 'empty-chapter',
          repository: _EmptyPagesRepository(),
        ),
      ),
    );

    expect(find.text('0 / 0'), findsOneWidget);
    expect(find.text('No pages available'), findsOneWidget);
    expect(find.text('1 / 0'), findsNothing);
  });

  testWidgets('updates page counter after swiping to next page', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ReaderScreen(
          chapterId: 'paged-chapter',
          repository: _ThreePagesRepository(),
        ),
      ),
    );

    expect(find.text('1 / 3'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text('2 / 3'), findsOneWidget);
  });

  testWidgets('bookmark button toggles the current page bookmark', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ReaderScreen(
          chapterId: 'paged-chapter',
          repository: _ThreePagesRepository(),
        ),
      ),
    );

    expect(find.byIcon(Icons.bookmark_add_outlined), findsOneWidget);

    await tester.tap(find.byTooltip('Bookmark page'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.bookmark), findsOneWidget);
    expect(find.text('Bookmarked page 1'), findsOneWidget);
  });
}

class _EmptyPagesRepository extends SeedLibraryRepository {
  @override
  List<ReaderPage> pagesForChapter(String chapterId) => [];
}

class _ThreePagesRepository extends SeedLibraryRepository {
  @override
  List<ReaderPage> pagesForChapter(String chapterId) {
    return List.generate(
      3,
      (index) => ReaderPage(
        id: '$chapterId-page-$index',
        chapterId: chapterId,
        index: index,
        sourcePath: 'seed://reader-test/$chapterId/page-$index',
        width: 1200,
        height: 1800,
        cachedImagePath: null,
      ),
    );
  }
}
