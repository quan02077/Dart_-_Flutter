import 'package:flutter/material.dart';

class BaiLop1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin sinh viên",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset("hinh_anh/Sau.jpg", width: 200, height: 200, ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text("Họ và tên: Nguyễn Nhật Minh Quân",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text("MSSV: 2001240388",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text("Lớp: 15DHTH05",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text("Khóa: 15 Đai học",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text("Ngành: Công nghệ thông tin",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text("Trường: Đai học Công Thương Thành phố Hồ Chí Minh",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(onPressed: () {}, child: const Text("Trở về")),
              ),
          ],
        ),
      ),
    );
  }
}