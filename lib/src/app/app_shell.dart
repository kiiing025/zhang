import 'package:flutter/material.dart';

import '../extensions/domain/extension_models.dart';
import '../extensions/presentation/extensions_screen.dart';
import '../importer/presentation/import_screen.dart';
import '../library/presentation/library_screen.dart';
import '../settings/presentation/settings_screen.dart';
import 'app_platform.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    this.platform,
    this.themeMode = ThemeMode.system,
    this.onThemeModeChanged,
  });

  final AppPlatform? platform;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final platform = widget.platform ?? currentAppPlatform();
    final screens = [
      const LibraryScreen(),
      ExtensionsScreen(platform: platform),
      const ImportScreen(),
      SettingsScreen(
        themeMode: widget.themeMode,
        onThemeModeChanged: widget.onThemeModeChanged,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.library_books_outlined),
            selectedIcon: Icon(Icons.library_books),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.extension_outlined),
            selectedIcon: Icon(Icons.extension),
            label: 'Extensions',
          ),
          NavigationDestination(
            icon: Icon(Icons.file_upload_outlined),
            selectedIcon: Icon(Icons.file_upload),
            label: 'Import',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
