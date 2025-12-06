import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../models/chat_session.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback onNewChat;
  final List<ChatSession> sessions;
  final String? currentSessionId;
  final Function(ChatSession) onSessionSelect;
  final Function(String) onSessionDelete;

  const Sidebar({
    Key? key,
    required this.onNewChat,
    required this.sessions,
    this.currentSessionId,
    required this.onSessionSelect,
    required this.onSessionDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildApiStatus(),
          _buildNewChatButton(),
          _buildChatHistory(),
          _buildSettingsButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: AppConfig.primaryGradient,
            ).createShader(bounds),
            child: const Text(
              'Cohere Clone',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApiStatus() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppConfig.useMockAPI ? Colors.orange.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppConfig.useMockAPI ? Colors.orange.shade200 : Colors.green.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            AppConfig.useMockAPI ? Icons.warning_amber : Icons.check_circle,
            color: AppConfig.useMockAPI ? Colors.orange : Colors.green,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppConfig.useMockAPI ? 'Demo Mode' : 'API Connected',
              style: TextStyle(
                fontSize: 12,
                color: AppConfig.useMockAPI ? Colors.orange.shade900 : Colors.green.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewChatButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onNewChat,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConfig.primaryGradient[0],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Cuộc trò chuyện mới'),
          ],
        ),
      ),
    );
  }

  Widget _buildChatHistory() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final isActive = session.id == currentSessionId;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFF3E8FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                Icons.chat_bubble_outline,
                color: isActive ? const Color(0xFF9333EA) : Colors.grey,
                size: 20,
              ),
              title: Text(
                session.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                _formatDate(session.updatedAt),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
              onTap: () => onSessionSelect(session),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline, size: 18, color: Colors.grey.shade600),
                onPressed: () => _confirmDelete(context, session),
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, ChatSession session) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa cuộc trò chuyện'),
        content: Text('Bạn có chắc muốn xóa "${session.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onSessionDelete(session.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0) {
      return 'Hôm nay';
    } else if (diff.inDays == 1) {
      return 'Hôm qua';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} ngày trước';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Widget _buildSettingsButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: InkWell(
        onTap: () => _showSettingsDialog(context),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: const [
              Icon(Icons.settings_outlined, color: Colors.grey),
              SizedBox(width: 12),
              Text('Hướng dẫn'),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hướng dẫn sử dụng'),
        content: const Text(
          '1. Lịch sử chat tự động lưu\n\n'
          '2. Click vào cuộc trò chuyện để xem lại\n\n'
          '3. Để dùng Cohere API thật:\n'
          '   - Đổi useMockAPI = false trong app_config.dart\n'
          '   - Thêm API key vào apiKey\n\n'
          '4. Lấy API key tại:\n'
          '   - Cohere: dashboard.cohere.com',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
}