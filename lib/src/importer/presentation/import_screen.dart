import 'package:flutter/material.dart';

class ImportScreen extends StatelessWidget {
  const ImportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: null,
            icon: const Icon(Icons.file_open),
            label: const Text('Choose files'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.folder_open),
            label: const Text('Choose folder'),
          ),
          const SizedBox(height: 24),
          Text(
            'Planned formats',
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
          const Card(
            child: ListTile(
              leading: Icon(Icons.inventory_2_outlined),
              title: Text('No files scanned yet'),
              subtitle: Text('Selected files will be reviewed before adding.'),
            ),
          ),
        ],
      ),
    );
  }
}
