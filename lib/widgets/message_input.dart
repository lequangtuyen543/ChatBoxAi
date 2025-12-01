import 'package:flutter/material.dart';
import '../config/app_config.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;

  const MessageInput({
    Key? key,
    required this.controller,
    required this.isLoading,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: controller,
                maxLines: null,
                enabled: !isLoading,
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
              gradient: const LinearGradient(
                colors: AppConfig.primaryGradient,
              ),
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