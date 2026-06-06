import 'package:flutter/material.dart';

import '../data/bundled_extension_registry.dart';
import '../domain/extension_models.dart';

class ExtensionsScreen extends StatefulWidget {
  const ExtensionsScreen({
    super.key,
    this.platform = AppPlatform.android,
    this.registry,
  });

  final AppPlatform platform;
  final BundledExtensionRegistry? registry;

  @override
  State<ExtensionsScreen> createState() => _ExtensionsScreenState();
}

class _ExtensionsScreenState extends State<ExtensionsScreen> {
  final Map<String, bool> _enabledOverrides = {};

  @override
  Widget build(BuildContext context) {
    final extensionRegistry = widget.registry ?? BundledExtensionRegistry();
    final extensions = extensionRegistry.extensionsFor(widget.platform);

    return Scaffold(
      appBar: AppBar(title: const Text('Extensions')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text('Installed', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          for (final extension in extensions) ...[
            _ExtensionTile(
              extension: extension,
              isEnabled: _enabledOverrides[extension.id] ?? extension.isEnabled,
              sourceCount: extensionRegistry
                  .sourcesForExtension(extension.id)
                  .length,
              onEnabledChanged: (value) => _setEnabled(extension, value),
            ),
            const SizedBox(height: 12),
          ],
          _GuardrailCard(platform: widget.platform),
        ],
      ),
    );
  }

  void _setEnabled(ZhangExtension extension, bool value) {
    setState(() {
      _enabledOverrides[extension.id] = value;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${extension.displayName} ${value ? 'enabled' : 'disabled'}',
        ),
      ),
    );
  }
}

class _ExtensionTile extends StatelessWidget {
  const _ExtensionTile({
    required this.extension,
    required this.isEnabled,
    required this.sourceCount,
    required this.onEnabledChanged,
  });

  final ZhangExtension extension;
  final bool isEnabled;
  final int sourceCount;
  final ValueChanged<bool> onEnabledChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: Icon(_iconFor(extension.type)),
        title: Text(extension.displayName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(extension.description),
            const SizedBox(height: 6),
            Text('Install source: ${extension.installSource}'),
            Text('$sourceCount ${sourceCount == 1 ? 'source' : 'sources'}'),
            Text('Status: ${isEnabled ? 'Enabled' : 'Disabled'}'),
          ],
        ),
        trailing: Switch(value: isEnabled, onChanged: onEnabledChanged),
        isThreeLine: true,
      ),
    );
  }

  IconData _iconFor(ExtensionType type) {
    return switch (type) {
      ExtensionType.local => Icons.folder_open,
      ExtensionType.selfHosted => Icons.dns_outlined,
      ExtensionType.curated => Icons.verified_outlined,
      ExtensionType.androidPackageLoader => Icons.android_outlined,
    };
  }
}

class _GuardrailCard extends StatelessWidget {
  const _GuardrailCard({required this.platform});

  final AppPlatform platform;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final message = switch (platform) {
      AppPlatform.android =>
        'Android can support signed external extension packages in a later build.',
      AppPlatform.ios =>
        'iOS uses bundled or reviewed connectors. It does not download executable extension code.',
    };

    return Card(
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.security_outlined, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
