import 'package:flutter/material.dart';

import '../extensions/domain/extension_models.dart';
import 'app_platform.dart';
import 'app_shell.dart';
import 'app_theme.dart';

class ZhangApp extends StatefulWidget {
  const ZhangApp({super.key, this.platform});

  final AppPlatform? platform;

  @override
  State<ZhangApp> createState() => _ZhangAppState();
}

class _ZhangAppState extends State<ZhangApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    final resolvedPlatform = widget.platform ?? currentAppPlatform();

    return MaterialApp(
      title: 'Zh\u0101ng',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      home: AppShell(
        platform: resolvedPlatform,
        themeMode: _themeMode,
        onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
      ),
    );
  }
}
