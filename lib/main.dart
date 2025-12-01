import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const CohereCloneApp());
}

class CohereCloneApp extends StatelessWidget {
  const CohereCloneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cohere Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFF5F3FF),
      ),
      home: const ChatScreen(),
    );
  }
}