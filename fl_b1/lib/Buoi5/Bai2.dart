import 'package:flutter/material.dart';

class state_BottomNavigate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Bai2_state();
  }
}

class _Bai2_state extends State<state_BottomNavigate>{
  int tabDangChon = 0;
  static const noiDung = <Widget>[
    Center(child: Text('Danh sách sản phẩm')),
    Center(child: Text('Giỏ hàng của bạn')),
    Center(child: Text('Trang cá nhân')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        foregroundColor: Colors.white,
        title: const Text('Cửa hàng'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: noiDung[tabDangChon],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabDangChon,
        selectedItemColor: Colors.teal,

        onTap: (chiSo) => setState(() {
          tabDangChon = chiSo;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Sản phẩm'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Giỏ hàng'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
      ),
    );
  }
}

class Bai2_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return state_BottomNavigate();
  }
}