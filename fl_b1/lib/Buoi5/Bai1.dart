import 'package:flutter/material.dart';

class Bai1_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(Icons.arrow_back),
        title: const Text('Tiêu đề'),
        // centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: Icon(Icons.sms)),
          IconButton(onPressed: () {}, icon: Icon(Icons.qr_code))
        ],
      ),
      body: const Text('Bài 1', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      floatingActionButton: IconButton(onPressed: () {}, icon: Icon(Icons.share)),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}