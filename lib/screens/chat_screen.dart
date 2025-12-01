import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/api_service.dart';
import '../widgets/sidebar.dart';
import '../widgets/message_list.dart';
import '../widgets/message_input.dart';
import '../config/app_config.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [
    Message(
      role: 'assistant',
      content: 'Xin chào! Tôi là trợ lý AI của bạn. Tôi có thể giúp gì cho bạn hôm nay?',
    ),
  ];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = Message(
      role: 'user',
      content: _controller.text.trim(),
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final response = await ApiService.sendMessage(_messages);
      setState(() {
        _messages.add(Message(
          role: 'assistant',
          content: response,
        ));
      });
    } catch (e) {
      setState(() {
        _messages.add(Message(
          role: 'assistant',
          content: 'Lỗi kết nối: $e\n\nVui lòng kiểm tra:\n1. Kết nối internet\n2. API key (nếu dùng API thật)\n3. Đổi useMockAPI = true để test giao diện',
        ));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _newChat() {
    setState(() {
      _messages.clear();
      _messages.add(Message(
        role: 'assistant',
        content: 'Xin chào! Tôi là trợ lý AI của bạn. Tôi có thể giúp gì cho bạn hôm nay?',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(onNewChat: _newChat),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: MessageList(
                    messages: _messages,
                    isLoading: _isLoading,
                    scrollController: _scrollController,
                  ),
                ),
                MessageInput(
                  controller: _controller,
                  isLoading: _isLoading,
                  onSend: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}