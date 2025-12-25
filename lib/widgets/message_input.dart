import 'package:flutter/material.dart';
import '../config/app_config.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;
  final FocusNode? focusNode;

  const MessageInput({
    Key? key,
    required this.controller,
    required this.isLoading,
    required this.onSend,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.dividerColor),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                maxLines: null,
                enabled: !isLoading,
                style: theme.textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: 'Nhập tin nhắn của bạn...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppConfig.primaryGradient),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: isLoading ? null : onSend,
              icon: const Icon(Icons.send, color: Colors.white),
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }
}
