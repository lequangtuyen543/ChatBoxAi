import 'package:flutter/material.dart';
import 'config/app_config.dart';
import 'config/theme_controller.dart';
import 'screens/chat_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  debugPrint('ENV COHERE_API_KEY = ${dotenv.env['COHERE_API_KEY']}');

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

