import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';
import '../config/app_config.dart';

class ApiService {
  static Future<String> sendMessage(List<Message> messages) async {
    try {
      if (AppConfig.useMockAPI) {
        return await _getMockResponse(messages.last.content);
      }

      final response = await http.post(
        Uri.parse(AppConfig.apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConfig.apiKey}',
        },
        body: jsonEncode({
          'model': AppConfig.modelName,
          'temperature': AppConfig.temperature,
          'messages': messages.map((msg) => msg.toJson()).toList(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message']['content'][0]['text'];
      } else {
        return 'Lỗi: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }

  static Future<String> _getMockResponse(String userMessage) async {
    await Future.delayed(const Duration(seconds: 1));

    final responses = {
      'xin chào': 'Xin chào! Rất vui được gặp bạn. Tôi có thể giúp gì cho bạn?',
      'bạn là ai': 'Tôi là trợ lý AI được phát triển để giúp đỡ bạn với nhiều câu hỏi và tác vụ khác nhau.',
      'hôm nay thế nào': 'Tôi luôn sẵn sàng giúp đỡ bạn! Bạn có câu hỏi gì không?',
    };

    final lowerMessage = userMessage.toLowerCase();

    for (var key in responses.keys) {
      if (lowerMessage.contains(key)) {
        return responses[key]!;
      }
    }

    return 'Tôi đã nhận được câu hỏi của bạn: "$userMessage". Đây là một ứng dụng demo, vui lòng thêm API key thật để có trải nghiệm đầy đủ!';
  }
}