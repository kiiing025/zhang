import 'package:flutter/material.dart';

class AppTheme {
  static const Color ink = Color(0xFF111111);
  static const Color paper = Color(0xFFF7F3EA);
  static const Color vermilion = Color(0xFFC93A2B);
  static const Color slate = Color(0xFF2C3333);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: vermilion,
      brightness: Brightness.light,
      primary: vermilion,
      surface: paper,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: paper,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: paper,
        foregroundColor: ink,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: vermilion.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: vermilion,
      brightness: Brightness.dark,
      primary: vermilion,
      surface: ink,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: ink,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: ink,
      ),
    );
  }
}
