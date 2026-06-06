import 'package:flutter_test/flutter_test.dart';
import 'package:zhang/src/extensions/data/bundled_extension_registry.dart';
import 'package:zhang/src/extensions/domain/extension_models.dart';

void main() {
  test('registry includes local files as an enabled built-in extension', () {
    final registry = BundledExtensionRegistry();

    final extensions = registry.extensionsFor(AppPlatform.android);
    final localFiles = extensions.singleWhere(
      (extension) => extension.id == 'local-files',
    );

    expect(localFiles.displayName, 'Local Files');
    expect(localFiles.isEnabled, isTrue);
    expect(localFiles.permissions, contains(ExtensionPermission.fileAccess));
    expect(localFiles.platformSupport.supports(AppPlatform.ios), isTrue);
  });

  test('registry hides android package loader on ios', () {
    final registry = BundledExtensionRegistry();

    final iosExtensions = registry.extensionsFor(AppPlatform.ios);
    final androidExtensions = registry.extensionsFor(AppPlatform.android);

    expect(
      iosExtensions.any(
        (extension) => extension.id == 'android-extension-packages',
      ),
      isFalse,
    );
    expect(
      androidExtensions.any(
        (extension) => extension.id == 'android-extension-packages',
      ),
      isTrue,
    );
  });

  test('available source connectors expose capability flags', () {
    final registry = BundledExtensionRegistry();

    final sources = registry.sourcesForExtension('local-files');

    expect(sources.single.displayName, 'Device library');
    expect(sources.single.supportsSearch, isTrue);
    expect(sources.single.supportsDownloads, isFalse);
  });
}
