import 'package:flutter/material.dart';
import '../models/message.dart';
import 'message_bubble.dart';
import 'loading_indicator.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;
  final bool isLoading;
  final ScrollController scrollController;

  const MessageList({
    Key? key,
    required this.messages,
    required this.isLoading,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(24),
      itemCount: messages.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length && isLoading) {
          return const LoadingIndicator();
        }

        final message = messages[index];
        return MessageBubble(message: message);
      },
    );
  }
}