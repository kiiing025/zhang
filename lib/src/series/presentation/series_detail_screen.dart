import 'package:flutter/material.dart';

import '../../library/data/seed_library_repository.dart';
import '../../reader/presentation/reader_screen.dart';

class SeriesDetailScreen extends StatelessWidget {
  const SeriesDetailScreen({
    super.key,
    required this.seriesId,
    this.repository,
  });

  final String seriesId;
  final SeedLibraryRepository? repository;

  @override
  Widget build(BuildContext context) {
    final libraryRepository = repository ?? SeedLibraryRepository();
    final series = libraryRepository.seriesById(seriesId);
    final chapters = libraryRepository.chaptersForSeries(seriesId);
    final continueChapter = libraryRepository.continueChapter(seriesId);

    if (series == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Series')),
        body: const Center(child: Text('Series not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(series.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(series.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(series.description),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: continueChapter == null
                ? null
                : () => _openReader(
                    context,
                    chapterId: continueChapter.id,
                    repository: libraryRepository,
                  ),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Continue'),
          ),
          const SizedBox(height: 16),
          Text('Chapters', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          for (final chapter in chapters)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(chapter.title),
              subtitle: Text('${chapter.pageCount} pages'),
              trailing: chapter.isRead
                  ? const Icon(Icons.check_circle)
                  : const Icon(Icons.radio_button_unchecked),
              onTap: () => _openReader(
                context,
                chapterId: chapter.id,
                repository: libraryRepository,
              ),
            ),
        ],
      ),
    );
  }

  void _openReader(
    BuildContext context, {
    required String chapterId,
    required SeedLibraryRepository repository,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            ReaderScreen(chapterId: chapterId, repository: repository),
      ),
    );
  }
}
