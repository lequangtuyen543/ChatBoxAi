import 'package:flutter/material.dart';
import '../config/app_config.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;
  final FocusNode? focusNode;

  const MessageInput({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSend,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          // top: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ================= INPUT =================
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 160),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  enabled: !isLoading,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                  decoration: InputDecoration(
                    hintText: 'Nhập tin nhắn…',
                    hintStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.hintColor),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onSubmitted: (_) {
                    // Desktop / web: Enter gửi
                    if (!isLoading) onSend();
                  },
                ),
              ),
            ),

            const SizedBox(width: 10),

            // ================= SEND BUTTON =================
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                gradient: isLoading
                    ? null
                    : const LinearGradient(
                        colors: AppConfig.primaryGradient,
                      ),
                color: isLoading ? theme.disabledColor : null,
                borderRadius: BorderRadius.circular(24),
              ),
              child: IconButton(
                onPressed: isLoading ? null : onSend,
                icon: isLoading
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.onSurface,
                          ),
                        ),
                      )
                    : const Icon(Icons.send_rounded),
                color: Colors.white,
                padding: const EdgeInsets.all(14),
                tooltip: 'Gửi',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
