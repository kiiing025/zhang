import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    this.themeMode = ThemeMode.system,
    this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ThemeMode _themeMode;
  String _readerMode = 'Single page';
  String _readingDirection = 'Right to left';
  String _extensionBehavior =
      'Bundled connectors on iOS, signed packages later on Android';

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
  }

  @override
  void didUpdateWidget(covariant SettingsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.themeMode != widget.themeMode) {
      _themeMode = widget.themeMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsTile(
            icon: Icons.brightness_6_outlined,
            title: 'Theme',
            value: _themeLabel(_themeMode),
            onTap: _chooseTheme,
          ),
          _SettingsTile(
            icon: Icons.chrome_reader_mode_outlined,
            title: 'Default reader mode',
            value: _readerMode,
            onTap: () => _chooseStringSetting(
              title: 'Default reader mode',
              values: const ['Single page', 'Double page', 'Vertical scroll'],
              currentValue: _readerMode,
              onSelected: (value) => setState(() => _readerMode = value),
            ),
          ),
          _SettingsTile(
            icon: Icons.swap_horiz,
            title: 'Reading direction',
            value: _readingDirection,
            onTap: () => _chooseStringSetting(
              title: 'Reading direction',
              values: const ['Right to left', 'Left to right', 'Webtoon'],
              currentValue: _readingDirection,
              onSelected: (value) => setState(() => _readingDirection = value),
            ),
          ),
          _SettingsTile(
            icon: Icons.extension_outlined,
            title: 'Extension behavior',
            value: _extensionBehavior,
            onTap: () => _chooseStringSetting(
              title: 'Extension behavior',
              values: const [
                'Bundled connectors on iOS, signed packages later on Android',
                'Strict bundled only',
                'Ask before enabling sources',
              ],
              currentValue: _extensionBehavior,
              onSelected: (value) => setState(() => _extensionBehavior = value),
            ),
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Content note',
            value:
                'Zh\u0101ng is for user-owned, self-hosted, open-license, or authorized content.',
            onTap: _showContentNote,
          ),
        ],
      ),
    );
  }

  Future<void> _chooseTheme() async {
    final selected = await showDialog<ThemeMode>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose theme'),
        children: [
          _ThemeOption(
            label: 'System',
            value: ThemeMode.system,
            selectedValue: _themeMode,
          ),
          _ThemeOption(
            label: 'Light',
            value: ThemeMode.light,
            selectedValue: _themeMode,
          ),
          _ThemeOption(
            label: 'Dark',
            value: ThemeMode.dark,
            selectedValue: _themeMode,
          ),
        ],
      ),
    );

    if (selected == null || selected == _themeMode) {
      return;
    }

    setState(() => _themeMode = selected);
    widget.onThemeModeChanged?.call(selected);
  }

  Future<void> _chooseStringSetting({
    required String title,
    required List<String> values,
    required String currentValue,
    required ValueChanged<String> onSelected,
  }) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(title),
        children: [
          for (final value in values)
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(value),
              child: Row(
                children: [
                  Icon(
                    value == currentValue
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(value)),
                ],
              ),
            ),
        ],
      ),
    );

    if (selected == null || selected == currentValue) {
      return;
    }

    onSelected(selected);
  }

  Future<void> _showContentNote() {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Authorized content only'),
        content: const Text(
          'Zh\u0101ng is designed for user-owned files, self-hosted libraries, open-license works, and sources you are authorized to access.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  String _themeLabel(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'System',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
    };
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.label,
    required this.value,
    required this.selectedValue,
  });

  final String label;
  final ThemeMode value;
  final ThemeMode selectedValue;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () => Navigator.of(context).pop(value),
      child: Row(
        children: [
          Icon(
            value == selectedValue
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
          ),
          const SizedBox(width: 12),
          Text(label),
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
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
