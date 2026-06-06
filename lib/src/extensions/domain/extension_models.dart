enum AppPlatform { android, ios }

enum ExtensionType { local, selfHosted, curated, androidPackageLoader }

enum ExtensionPermission { fileAccess, networkAccess, credentials, downloads }

enum ContentRating { allAges, teen, mature }

class PlatformSupport {
  const PlatformSupport({
    required this.android,
    required this.ios,
    required this.note,
  });

  final bool android;
  final bool ios;
  final String note;

  bool supports(AppPlatform platform) {
    return switch (platform) {
      AppPlatform.android => android,
      AppPlatform.ios => ios,
    };
  }
}

class ZhangExtension {
  const ZhangExtension({
    required this.id,
    required this.displayName,
    required this.type,
    required this.version,
    required this.author,
    required this.description,
    required this.platformSupport,
    required this.permissions,
    required this.contentRating,
    required this.isEnabled,
    required this.installSource,
  });

  final String id;
  final String displayName;
  final ExtensionType type;
  final String version;
  final String author;
  final String description;
  final PlatformSupport platformSupport;
  final List<ExtensionPermission> permissions;
  final ContentRating contentRating;
  final bool isEnabled;
  final String installSource;
}

class SourceDefinition {
  const SourceDefinition({
    required this.id,
    required this.extensionId,
    required this.displayName,
    required this.baseUrl,
    required this.supportsSearch,
    required this.supportsBrowse,
    required this.supportsDownloads,
    required this.requiresCredentials,
    required this.isEnabled,
  });

  final String id;
  final String extensionId;
  final String displayName;
  final String? baseUrl;
  final bool supportsSearch;
  final bool supportsBrowse;
  final bool supportsDownloads;
  final bool requiresCredentials;
  final bool isEnabled;
}

class SourceSearchResult {
  const SourceSearchResult({
    required this.externalSeriesId,
    required this.sourceId,
    required this.title,
    required this.description,
    required this.coverUrl,
  });

  final String externalSeriesId;
  final String sourceId;
  final String title;
  final String description;
  final String? coverUrl;
}
