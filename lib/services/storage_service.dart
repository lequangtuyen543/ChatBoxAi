import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_session.dart';
import '../models/message.dart';

class StorageService {
  static const String _sessionsKey = 'chat_sessions';
  static const String _currentSessionKey = 'current_session_id';

  // Lưu tất cả sessions
  static Future<void> saveSessions(List<ChatSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = sessions.map((s) => s.toMap()).toList();
    await prefs.setString(_sessionsKey, jsonEncode(sessionsJson));
  }

  // Lấy tất cả sessions
  static Future<List<ChatSession>> getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsString = prefs.getString(_sessionsKey);
    
    if (sessionsString == null) return [];
    
    final List<dynamic> sessionsJson = jsonDecode(sessionsString);
    return sessionsJson.map((s) => ChatSession.fromMap(s)).toList();
  }

  // Lưu session hiện tại
  static Future<void> saveCurrentSession(ChatSession session) async {
    final sessions = await getSessions();
    final index = sessions.indexWhere((s) => s.id == session.id);
    
    if (index >= 0) {
      sessions[index] = session;
    } else {
      sessions.insert(0, session);
    }
    
    await saveSessions(sessions);
    await setCurrentSessionId(session.id);
  }

  // Xóa session
  static Future<void> deleteSession(String sessionId) async {
    final sessions = await getSessions();
    sessions.removeWhere((s) => s.id == sessionId);
    await saveSessions(sessions);
  }

  // Lưu ID session hiện tại
  static Future<void> setCurrentSessionId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentSessionKey, id);
  }

  // Lấy ID session hiện tại
  static Future<String?> getCurrentSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentSessionKey);
  }

  // Xóa tất cả dữ liệu
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionsKey);
    await prefs.remove(_currentSessionKey);
  }
}