import 'package:flutter/material.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  List<_ImportPreview> _previews = const [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: _scanFiles,
            icon: const Icon(Icons.file_open),
            label: const Text('Choose files'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _scanFolder,
            icon: const Icon(Icons.folder_open),
            label: const Text('Choose folder'),
          ),
          const SizedBox(height: 24),
          Text(
            'Supported formats',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text('CBZ, ZIP, PDF, and image folders selected by the user.'),
          const SizedBox(height: 24),
          Text(
            'Scan result preview',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (_previews.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.inventory_2_outlined),
                title: Text('No files scanned yet'),
                subtitle: Text('Selected files will be reviewed before adding.'),
              ),
            )
          else ...[
            Text(
              '${_previews.length} items ready to import',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            for (final preview in _previews)
              Card(
                child: ListTile(
                  leading: Icon(preview.icon),
                  title: Text(preview.name),
                  subtitle: Text(preview.detail),
                  trailing: const Icon(Icons.check_circle_outline),
                ),
              ),
          ],
        ],
      ),
    );
  }

  void _scanFiles() {
    setState(() {
      _previews = const [
        _ImportPreview(
          name: 'Moonlit Atlas - Chapter 14.cbz',
          detail: '34 pages detected',
          icon: Icons.inventory_2_outlined,
        ),
        _ImportPreview(
          name: 'Iron Plum - Orchard Extras.zip',
          detail: '12 pages detected',
          icon: Icons.inventory_2_outlined,
        ),
      ];
    });
  }

  void _scanFolder() {
    setState(() {
      _previews = const [
        _ImportPreview(
          name: 'Rain Index - Local Folder',
          detail: '42 images detected',
          icon: Icons.folder_open,
        ),
      ];
    });
  }
}

class _ImportPreview {
  const _ImportPreview({
    required this.name,
    required this.detail,
    required this.icon,
  });

  final String name;
  final String detail;
  final IconData icon;
}
