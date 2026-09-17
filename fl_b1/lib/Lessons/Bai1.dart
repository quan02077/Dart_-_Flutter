import 'package:flutter/material.dart';

class Bai1Screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (
          AppBar(title: const Text("Sử dụng Text and Image", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blue,
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
          )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text("Lập trình di động", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            ),
            Center(
              child: Image.asset("hinh_anh/images.jpg"),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text("Ri Đô chúc bạn 1 ngày vui", style: TextStyle(fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text("Critiana Ranalda", style: TextStyle(fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text("SIUUUUUUU", style: TextStyle(fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }

}