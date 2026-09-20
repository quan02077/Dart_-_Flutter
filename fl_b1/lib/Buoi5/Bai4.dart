import 'package:flutter/material.dart';

class Bai4_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return manHinhChinh();
  }
}

class manHinhChinh extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 4'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => manHinhChiTiet(),
                ),
              );
            },
            child: const Text('Áo thun nam')
        ),
      ),
    );
  }
}

class manHinhChiTiet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Áo thun nam', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('150000 đồng', style: TextStyle(color: Colors.red),),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: const Text('Quay lại')
            )
          ],
        ),
      )
    );
  }

}