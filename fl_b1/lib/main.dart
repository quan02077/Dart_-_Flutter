import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: InfoInputWidget(),
    ),
  );
}

class InfoInputWidget extends StatefulWidget {
  const InfoInputWidget({super.key});

  @override
  State<InfoInputWidget> createState() => _InfoInputWidgetState();
}

class _InfoInputWidgetState extends State<InfoInputWidget> {
  // 1. Tạo Controller để quản lý dữ liệu ô nhập
  final TextEditingController _nameController = TextEditingController();
  String _displayName = "";
  @override
  void dispose() {
    // 2. Bắt buộc hủy controller khi Widget bị hủy để giải phóng bộ nhớ
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thông tin cá nhân")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Họ và tên:"),
            const SizedBox(height: 8),

            // 3. Đặt TextField và gắn Controller vào
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập họ và tên của bạn",
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _displayName = _nameController.text;
                });
              },
              child: const Text("Lưu thông tin"),
            ),
            const SizedBox(height: 16),
            Text("Tên vừa lưu: $_displayName"),
          ],
        ),
      ),
    );
  }
}