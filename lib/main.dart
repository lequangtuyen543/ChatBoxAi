import 'package:flutter/material.dart';
import 'config/app_config.dart';
import 'config/theme_controller.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (_, themeMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppConfig.lightTheme,
          darkTheme: AppConfig.darkTheme,
          themeMode: themeMode,
          home: const ChatScreen(),
        );
      },
    );
  }
}
