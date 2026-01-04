import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // ================= API =================
  static final String apiKey = dotenv.env['COHERE_API_KEY'] ?? '';
  static const String apiUrl = 'https://api.cohere.com/v2/chat';
  static const String modelName = 'command-a-03-2025';
  static const double temperature = 0.3;
  static const bool useMockAPI = false;

  // ================= PI AI COLOR =================
  static const Color piPrimary = Color(0xFF6D5EF6); // tím dịu
  static const Color piSecondary = Color(0xFF8B7CFF);

  static const List<Color> primaryGradient = [
    piPrimary,
    piSecondary,
  ];

  // ================= TEXT THEME (PI STYLE) =================
  static TextTheme _piTextTheme(Brightness brightness) {
    final baseColor =
        brightness == Brightness.dark ? Colors.white : Colors.black87;

    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.6,
        color: baseColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        height: 1.6,
        color: baseColor.withOpacity(0.9),
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        height: 1.5,
        color: baseColor.withOpacity(0.7),
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
    );
  }

  // ================= LIGHT THEME =================
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: piPrimary,
      brightness: Brightness.light,
      background: const Color(0xFFF7F7FB),
      surface: Colors.white,
    ),

    scaffoldBackgroundColor: const Color(0xFFF7F7FB),

    textTheme: _piTextTheme(Brightness.light),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: false,
    ),

    dividerColor: Colors.black12,

    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black54,
      textColor: Colors.black87,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
    ),

    iconTheme: const IconThemeData(size: 20),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );

  // ================= DARK THEME =================
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: piPrimary,
      brightness: Brightness.dark,
      background: const Color(0xFF12121A),
      surface: const Color(0xFF1A1A24),
    ),

    scaffoldBackgroundColor: const Color(0xFF12121A),

    textTheme: _piTextTheme(Brightness.dark),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    dividerColor: Colors.white12,

    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white70,
      textColor: Colors.white70,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
    ),

    iconTheme: const IconThemeData(size: 20),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1E1E2A),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
