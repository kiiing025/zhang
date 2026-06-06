import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SettingsTile(
            icon: Icons.brightness_6_outlined,
            title: 'Theme',
            value: 'System',
          ),
          _SettingsTile(
            icon: Icons.chrome_reader_mode_outlined,
            title: 'Default reader mode',
            value: 'Single page',
          ),
          _SettingsTile(
            icon: Icons.swap_horiz,
            title: 'Reading direction',
            value: 'Right to left',
          ),
          _SettingsTile(
            icon: Icons.extension_outlined,
            title: 'Extension behavior',
            value:
                'Bundled connectors on iOS, signed packages later on Android',
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Content note',
            value:
                'Zh\u0101ng is for user-owned, self-hosted, open-license, or authorized content.',
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
