class Message {
  final String role;
  final String content;
  final DateTime timestamp;

  Message({
    required this.role,
    required this.content,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': [
        {
          'type': 'text',
          'text': content,
        }
      ],
    };
  }

  // Chuyển thành Map để lưu vào storage
  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Tạo Message từ Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      role: map['role'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: json['role'],
      content: json['content'],
    );
  }
}