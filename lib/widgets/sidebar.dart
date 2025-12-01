import 'package:flutter/material.dart';
import '../config/app_config.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback onNewChat;

  const Sidebar({
    Key? key,
    required this.onNewChat,
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
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E8FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.chat_bubble_outline, color: Color(0xFF9333EA), size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Cuộc trò chuyện hiện tại',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
          '1. Đang ở chế độ Demo (Mock API)\n\n'
          '2. Để dùng Cohere API thật:\n'
          '   - Đổi useMockAPI = false trong app_config.dart\n'
          '   - Thêm API key vào apiKey\n\n'
          '3. Lấy API key tại:\n'
          '   - Cohere: dashboard.cohere.com\n'
          '   - Tạo tài khoản miễn phí\n'
          '   - Copy API key từ dashboard',
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