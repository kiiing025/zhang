import '../domain/extension_models.dart';

class BundledExtensionRegistry {
  static const ZhangExtension localFiles = ZhangExtension(
    id: 'local-files',
    displayName: 'Local Files',
    type: ExtensionType.local,
    version: '1.0.0',
    author: 'Zhāng',
    description: 'Import CBZ, ZIP, PDF, and image folders from your device.',
    platformSupport: PlatformSupport(
      android: true,
      ios: true,
      note: 'Uses platform file pickers and user-selected files.',
    ),
    permissions: [ExtensionPermission.fileAccess],
    contentRating: ContentRating.allAges,
    isEnabled: true,
    installSource: 'bundled',
  );

  static const ZhangExtension selfHostedFoundation = ZhangExtension(
    id: 'self-hosted-foundation',
    displayName: 'Self-hosted Library',
    type: ExtensionType.selfHosted,
    version: '0.1.0',
    author: 'Zhāng',
    description: 'Foundation for OPDS, Komga, Kavita, and WebDAV connectors.',
    platformSupport: PlatformSupport(
      android: true,
      ios: true,
      note: 'Uses app-shipped connector code and user-provided server URLs.',
    ),
    permissions: [
      ExtensionPermission.networkAccess,
      ExtensionPermission.credentials,
    ],
    contentRating: ContentRating.teen,
    isEnabled: false,
    installSource: 'bundled',
  );

  static const ZhangExtension androidPackageLoader = ZhangExtension(
    id: 'android-extension-packages',
    displayName: 'Android Extension Packages',
    type: ExtensionType.androidPackageLoader,
    version: '0.1.0',
    author: 'Zhāng',
    description: 'Android-only foundation for signed external extensions.',
    platformSupport: PlatformSupport(
      android: true,
      ios: false,
      note: 'iOS App Store builds cannot download executable connector code.',
    ),
    permissions: [ExtensionPermission.networkAccess],
    contentRating: ContentRating.teen,
    isEnabled: false,
    installSource: 'android-only',
  );

  final List<ZhangExtension> _extensions = const [
    localFiles,
    selfHostedFoundation,
    androidPackageLoader,
  ];

  final List<SourceDefinition> _sources = const [
    SourceDefinition(
      id: 'device-library',
      extensionId: 'local-files',
      displayName: 'Device library',
      baseUrl: null,
      supportsSearch: true,
      supportsBrowse: true,
      supportsDownloads: false,
      requiresCredentials: false,
      isEnabled: true,
    ),
    SourceDefinition(
      id: 'self-hosted-server',
      extensionId: 'self-hosted-foundation',
      displayName: 'Self-hosted server',
      baseUrl: null,
      supportsSearch: true,
      supportsBrowse: true,
      supportsDownloads: true,
      requiresCredentials: true,
      isEnabled: false,
    ),
  ];

  List<ZhangExtension> extensionsFor(AppPlatform platform) {
    return _extensions
        .where((extension) => extension.platformSupport.supports(platform))
        .toList(growable: false);
  }

  List<SourceDefinition> sourcesForExtension(String extensionId) {
    return _sources
        .where((source) => source.extensionId == extensionId)
        .toList(growable: false);
  }
}
