import 'package:flutter/material.dart';

class ChatWidthWrapper extends StatelessWidget {
  final Widget child;

  const ChatWidthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 760, // giống ChatGPT
        ),
        child: child,
      ),
    );
  }
}
