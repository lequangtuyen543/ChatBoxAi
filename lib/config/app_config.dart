import 'package:flutter/material.dart';

class AppConfig {
  // ================= API =================
  static const String apiKey = '9rGKBUWyqwhlf7DUs9gu2wblXgatcT2ZLWh5pExH';
  static const String apiUrl = 'https://api.cohere.com/v2/chat';
  static const String modelName = 'command-a-03-2025';
  static const double temperature = 0.3;
  static const bool useMockAPI = false;

  // ================= GRADIENT =================
  static const List<Color> primaryGradient = [
    Color(0xFF9333EA),
    Color(0xFF2563EB),
  ];

  // ================= LIGHT THEME =================
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F3FF),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    dividerColor: Colors.grey.shade200,
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black87,
      textColor: Colors.black87,
    ),
  );

  // ================= DARK THEME =================
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F0F14),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF18181F),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    dividerColor: Colors.grey.shade800,
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white70,
      textColor: Colors.white70,
    ),
  );
}
