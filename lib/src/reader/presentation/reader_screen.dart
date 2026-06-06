import 'package:flutter/material.dart';

import '../../library/data/seed_library_repository.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key, required this.chapterId, this.repository});

  final String chapterId;
  final SeedLibraryRepository? repository;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late final PageController _controller;
  final Set<int> _bookmarkedPages = {};
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = widget.repository ?? SeedLibraryRepository();
    final pages = repository.pagesForChapter(widget.chapterId);
    final pageCount = pages.length;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          pageCount == 0 ? '0 / 0' : '${_pageIndex + 1} / $pageCount',
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Bookmark page',
            onPressed: pageCount == 0 ? null : _toggleBookmark,
            icon: Icon(
              _bookmarkedPages.contains(_pageIndex)
                  ? Icons.bookmark
                  : Icons.bookmark_add_outlined,
            ),
          ),
        ],
      ),
      body: pageCount == 0
          ? const Center(
              child: Text(
                'No pages available',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : PageView.builder(
              controller: _controller,
              itemCount: pageCount,
              onPageChanged: (index) => setState(() => _pageIndex = index),
              itemBuilder: (context, index) {
                final page = pages[index];

                return InteractiveViewer(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: page.width / page.height,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D1D1D),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Center(
                          child: Text(
                            'Page ${page.index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _toggleBookmark() {
    final isBookmarked = _bookmarkedPages.contains(_pageIndex);
    setState(() {
      if (isBookmarked) {
        _bookmarkedPages.remove(_pageIndex);
      } else {
        _bookmarkedPages.add(_pageIndex);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBookmarked
              ? 'Removed bookmark from page ${_pageIndex + 1}'
              : 'Bookmarked page ${_pageIndex + 1}',
        ),
      ),
    );
  }
}
