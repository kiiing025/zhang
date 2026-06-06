import 'package:flutter/material.dart';

import '../../series/presentation/series_detail_screen.dart';
import '../data/seed_library_repository.dart';
import '../domain/library_models.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key, this.repository});

  final SeedLibraryRepository? repository;

  @override
  Widget build(BuildContext context) {
    final libraryRepository = repository ?? SeedLibraryRepository();
    final series = libraryRepository.watchSeries();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('章', style: TextStyle(fontWeight: FontWeight.w800)),
            SizedBox(width: 12),
            Text('Library'),
          ],
        ),
        actions: const [
          IconButton(
            tooltip: 'Search library',
            onPressed: null,
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _ContinueShelf(series: series.first),
          const SizedBox(height: 20),
          Text('All series', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
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
}

class _ContinueShelf extends StatelessWidget {
  const _ContinueShelf({required this.series});

  final Series series;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Continue', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    text: series.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: series.progressLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
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
                        text: '章',
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
