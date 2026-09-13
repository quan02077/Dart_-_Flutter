import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(width: double.infinity, child: MyText()),
        ),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Xin chào!"),
        const Text("Toi la Quan", style: TextStyle(color: Colors.blue)),
        const Text("Xin chào!"),
        const Text("Toi la Messi", style: TextStyle(color: Colors.blue)),
        const Text("Xin chào!"),
        const Text("Toi la A Buoi", style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}
