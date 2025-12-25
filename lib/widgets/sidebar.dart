import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../config/theme_controller.dart';
import '../models/chat_session.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback onNewChat;
  final List<ChatSession> sessions;
  final String? currentSessionId;
  final Function(ChatSession) onSessionSelect;
  final Function(String) onSessionDelete;
  final VoidCallback? onClose;

  const Sidebar({
    super.key,
    required this.onNewChat,
    required this.sessions,
    this.currentSessionId,
    required this.onSessionSelect,
    required this.onSessionDelete,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        children: [
          _buildHeader(theme),
          _buildNewChatButton(),
          _buildChatHistory(theme),
          const Divider(height: 1),
          _buildSettingsSection(theme),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: AppConfig.primaryGradient,
              ).createShader(bounds),
              child: const Text(
                'Cohere Clone',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (onClose != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onClose,
            ),
        ],
      ),
    );
  }

  // ================= NEW CHAT =================
  Widget _buildNewChatButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton.icon(
        onPressed: onNewChat,
        icon: const Icon(Icons.add),
        label: const Text('Cuộc trò chuyện mới'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConfig.primaryGradient[0],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ================= CHAT HISTORY =================
  Widget _buildChatHistory(ThemeData theme) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final isActive = session.id == currentSessionId;

          return Container(
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: isActive
                  ? theme.colorScheme.primary.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                Icons.chat_bubble_outline,
                size: 20,
                color: isActive
                    ? theme.colorScheme.primary
                    : theme.iconTheme.color,
              ),
              title: Text(
                session.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => onSessionSelect(session),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => onSessionDelete(session.id),
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= SETTINGS =================
  Widget _buildSettingsSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'CÀI ĐẶT',
              style: theme.textTheme.labelSmall?.copyWith(
                letterSpacing: 1,
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
            ),
          ),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeController.themeMode,
            builder: (_, mode, __) {
              final isDark = mode == ThemeMode.dark;

              return SwitchListTile(
                dense: true,
                title: const Text('Dark Mode'),
                secondary: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                ),
                value: isDark,
                onChanged: (value) {
                  ThemeController.toggleTheme(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
