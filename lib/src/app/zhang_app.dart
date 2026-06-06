import 'package:flutter/material.dart';

import '../extensions/domain/extension_models.dart';
import 'app_platform.dart';
import 'app_shell.dart';
import 'app_theme.dart';

class ZhangApp extends StatelessWidget {
  const ZhangApp({super.key, this.platform});

  final AppPlatform? platform;

  @override
  Widget build(BuildContext context) {
    final resolvedPlatform = platform ?? currentAppPlatform();

    return MaterialApp(
      title: 'Zhāng',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: AppShell(platform: resolvedPlatform),
    );
  }
}
