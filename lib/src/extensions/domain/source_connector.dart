import '../../library/domain/library_models.dart';
import 'extension_models.dart';

abstract interface class SourceConnector {
  String get id;
  SourceDefinition get source;

  Future<List<SourceSearchResult>> search(String query);
  Future<List<SourceSearchResult>> browse(String category, int page);
  Future<SourceSearchResult> getSeries(String externalSeriesId);
  Future<List<Chapter>> getChapters(String externalSeriesId);
  Future<List<ReaderPage>> getPages(String externalChapterId);
  Future<bool> downloadChapter(String externalChapterId);
  Future<Map<String, String>> getMetadata(String externalSeriesId);
  Future<bool> testConnection();
}
