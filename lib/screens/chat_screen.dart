import 'package:flutter/material.dart';
import '../models/message.dart';
import '../models/chat_session.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
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
  List<Message> _messages = [];
  ChatSession? _currentSession;
  List<ChatSession> _allSessions = [];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  bool _isLoading = false;
  bool _isSidebarVisible = false;

  @override
  void initState() {
    super.initState();
    _loadSessions();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Load sessions từ storage
  Future<void> _loadSessions() async {
    final sessions = await StorageService.getSessions();
    final currentId = await StorageService.getCurrentSessionId();

    setState(() {
      _allSessions = sessions;

      if (currentId != null) {
        _currentSession = sessions.firstWhere(
          (s) => s.id == currentId,
          orElse: () => _createNewSession(),
        );
      } else {
        _currentSession = _createNewSession();
      }

      _messages = List.from(_currentSession!.messages);
    });

    // Focus sau khi UI đã có TextField
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  // Tạo session mới
  ChatSession _createNewSession() {
    return ChatSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Cuộc trò chuyện mới',
      messages: [
        Message(
          role: 'assistant',
          content:
              'Xin chào! Tôi là trợ lý AI của bạn. Tôi có thể giúp gì cho bạn hôm nay?',
        ),
      ],
    );
  }

  // Lưu session hiện tại
  Future<void> _saveCurrentSession() async {
    if (_currentSession == null) return;

    // Cập nhật title nếu chưa có
    String title = _currentSession!.title;
    if (title == 'Cuộc trò chuyện mới' && _messages.length > 1) {
      title = ChatSession.generateTitle(_messages);
    }

    final updatedSession = ChatSession(
      id: _currentSession!.id,
      title: title,
      messages: _messages,
      createdAt: _currentSession!.createdAt,
      updatedAt: DateTime.now(),
    );

    await StorageService.saveCurrentSession(updatedSession);

    setState(() {
      _currentSession = updatedSession;
    });

    await _loadSessions();
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

    final userMessage = Message(role: 'user', content: _controller.text.trim());

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final response = await ApiService.sendMessage(_messages);
      setState(() {
        _messages.add(Message(role: 'assistant', content: response));
      });

      // Lưu sau mỗi tin nhắn
      await _saveCurrentSession();
    } catch (e) {
      setState(() {
        _messages.add(
          Message(
            role: 'assistant',
            content:
                'Lỗi kết nối: $e\n\nVui lòng kiểm tra:\n1. Kết nối internet\n2. API key (nếu dùng API thật)\n3. Đổi useMockAPI = true để test giao diện',
          ),
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _newChat() {
    final newSession = _createNewSession();

    setState(() {
      _currentSession = newSession;
      _messages = List.from(newSession.messages);
      _isSidebarVisible = false; // Đóng sidebar
    });

    StorageService.setCurrentSessionId(newSession.id);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _loadSession(ChatSession session) {
    setState(() {
      _currentSession = session;
      _messages = List.from(session.messages);
      _isSidebarVisible = false; // Đóng sidebar khi chọn session
    });

    StorageService.setCurrentSessionId(session.id);
    _scrollToBottom();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  Future<void> _deleteSession(String sessionId) async {
    await StorageService.deleteSession(sessionId);

    if (_currentSession?.id == sessionId) {
      _newChat();
    }

    await _loadSessions();
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });

    if (_isSidebarVisible) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content - Full width
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isSidebarVisible ? Icons.menu_open : Icons.menu,
                      ),
                      onPressed: _toggleSidebar,
                      tooltip: _isSidebarVisible
                          ? 'Đóng sidebar'
                          : 'Mở sidebar',
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _currentSession?.title ?? 'Cohere Chat',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
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
                focusNode: _focusNode,
              ),
            ],
          ),

          // Sidebar overlay - Đè lên trên
          if (_isSidebarVisible)
            GestureDetector(
              onTap: _toggleSidebar,
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          if (_isSidebarVisible)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 280,
              child: Sidebar(
                onNewChat: _newChat,
                sessions: _allSessions,
                currentSessionId: _currentSession?.id,
                onSessionSelect: _loadSession,
                onSessionDelete: _deleteSession,
                onClose: _toggleSidebar,
              ),
            ),
        ],
      ),
    );
  }
}
