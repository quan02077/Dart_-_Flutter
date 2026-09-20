import 'package:flutter/material.dart';

class Bai3_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return bottomSheet();
  }

}

class bottomSheet extends StatelessWidget{
    void showThanhTruot(BuildContext context){
      showModalBottomSheet(
          context: context,
          builder: (context) => Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lọc theo giá',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text('Dưới 200.000đ'),
                    const Text('Từ 200.000đ tới 500.000đ'),
                    const Text('Trên 500.000đ'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Đóng'),
                    ),
                  ],
                ),
              ),
          )
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Tiêu đề'),
          foregroundColor: Colors.white,
        ),
      body: Center(
        child: ElevatedButton(onPressed: () => showThanhTruot(context), child: const Text('Hiện thanh trượt')),
      )
    );
  }
}