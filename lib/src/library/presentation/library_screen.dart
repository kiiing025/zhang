import 'package:flutter/material.dart';

import '../../reader/presentation/reader_screen.dart';
import '../../series/presentation/series_detail_screen.dart';
import '../data/seed_library_repository.dart';
import '../domain/library_models.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key, this.repository});

  final SeedLibraryRepository? repository;

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool _isSearching = false;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final libraryRepository = widget.repository ?? SeedLibraryRepository();
    final allSeries = libraryRepository.watchSeries();
    final series = _filteredSeries(allSeries);
    final isFiltered = _query.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search library',
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) => setState(() => _query = value),
              )
            : const Row(
                children: [
                  Text('\u7AE0', style: TextStyle(fontWeight: FontWeight.w800)),
                  SizedBox(width: 12),
                  Text('Library'),
                ],
              ),
        actions: [
          if (_isSearching)
            IconButton(
              tooltip: 'Close search',
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _query = '';
                });
              },
              icon: const Icon(Icons.close),
            )
          else
            IconButton(
              tooltip: 'Search library',
              onPressed: () => setState(() => _isSearching = true),
              icon: const Icon(Icons.search),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          if (!isFiltered && allSeries.isNotEmpty) ...[
            _ContinueShelf(
              series: allSeries.first,
              onTap: () => _openContinueChapter(
                context,
                series: allSeries.first,
                repository: libraryRepository,
              ),
            ),
            const SizedBox(height: 20),
          ],
          Text('All series', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          if (series.isEmpty)
            const _EmptyLibrarySearch()
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.68,
              ),
              itemCount: series.length,
              itemBuilder: (context, index) {
                return _SeriesCard(
                  series: series[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => SeriesDetailScreen(
                          seriesId: series[index].id,
                          repository: libraryRepository,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  List<Series> _filteredSeries(List<Series> series) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) {
      return series;
    }

    return series.where((item) {
      return item.title.toLowerCase().contains(query) ||
          item.author.toLowerCase().contains(query) ||
          item.artist.toLowerCase().contains(query) ||
          item.categories.any(
            (category) => category.toLowerCase().contains(query),
          );
    }).toList(growable: false);
  }

  void _openContinueChapter(
    BuildContext context, {
    required Series series,
    required SeedLibraryRepository repository,
  }) {
    final chapter = repository.continueChapter(series.id);
    if (chapter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No chapters available yet')),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            ReaderScreen(chapterId: chapter.id, repository: repository),
      ),
    );
  }
}

class _ContinueShelf extends StatelessWidget {
  const _ContinueShelf({required this.series, required this.onTap});

  final Series series;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Continue',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        text: series.title,
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(color: colorScheme.onPrimaryContainer),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: series.progressLabel,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: colorScheme.onPrimaryContainer),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.play_arrow_rounded,
                size: 36,
                color: colorScheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyLibrarySearch extends StatelessWidget {
  const _EmptyLibrarySearch();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 36,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              'No series found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            const Text('Try another title, creator, or category.'),
          ],
        ),
      ),
    );
  }
}

class _SeriesCard extends StatelessWidget {
  const _SeriesCard({required this.series, required this.onTap});

  final Series series;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: colorScheme.surface,
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: '\u7AE0',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                series.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(series.progressLabel),
              Text('${series.unreadCount} unread'),
            ],
          ),
        ),
      ),
    );
  }
}
