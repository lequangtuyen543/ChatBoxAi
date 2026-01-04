# 🤖 ChatBox AI (Flutter)

Ứng dụng **ChatBox AI** được xây dựng bằng **Flutter (Dart)**, mô phỏng chatbox AI thông qua việc gọi API và hiển thị giao diện chat hiện đại, hỗ trợ **dark mode**, lưu lịch sử chat cục bộ và render Markdown / code.

---

## 📌 Thông tin dự án
- **Tên dự án:** ChatBox AI
- **Mục tiêu:** Clone chatbox AI đơn giản trên mobile
- **Thời gian thực hiện:** ~3 tuần  
  *(17/12/2025 → 04/01/2025)*
- **Nền tảng:** Flutter (Android / iOS / Web)

---

## 🚀 Tính năng chính
- Gửi & nhận tin nhắn AI qua API
- Hiển thị Markdown (bold, italic, code block)
- Highlight code theo ngôn ngữ
- Lưu lịch sử chat bằng Local Storage
- Sidebar quản lý phiên chat
- Dark / Light mode toggle
- Tự động focus & mở bàn phím khi vào app

---

## 📜 Lịch sử commit
1. Khởi tạo dự án Flutter  
2. Phân chia cấu trúc dự án  
3. Đẩy lên GitHub, thêm toggle  
4. Lưu lịch sử chat (Local Storage)  
5. Fix toggle & màn hình chính  
6. Fix con trỏ ô nhập  
7. Fix hiển thị bàn phím mobile  
8. Fix hiển thị bàn phím lúc mở app  
9. Đổi theme color, app icon & page title  
10. Thêm Dark Mode  

---

## 📁 Cấu trúc dự án
```bash
lib/
├── config/        # App config, theme, API
├── models/        # Message, ChatSession
├── services/      # API & Local storage
├── screens/       # Chat screen
├── widgets/       # UI components
└── main.dart
````

---

## 📦 Dependencies chính

```yaml
http
shared_preferences
flutter_launcher_icons
flutter_markdown
flutter_highlight
```

---

## 🛠 Ghi chú

* Có thể bật `useMockAPI = true` để test UI không tốn API
* Thiết kế UI & typography tham khảo phong cách **Pi AI**

---

## 📄 License

Dự án học tập cá nhân, phục vụ mục đích học Flutter & Mobile Development.