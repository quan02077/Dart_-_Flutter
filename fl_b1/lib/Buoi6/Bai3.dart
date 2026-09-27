import 'package:flutter/material.dart';

class ManHinhThongBao extends StatelessWidget {
  const ManHinhThongBao({super.key});

  void hienThongBao(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đặt hàng thành công'),
        content: const Text('Đơn của bạn đã được ghi nhận. '
            'Chúng tôi sẽ gọi xác nhận trong hôm nay.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đã hiểu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hộp thoại một nút'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => hienThongBao(context),
          child: const Text('Đặt hàng'),
        ),
      ),
    );
  }
}
