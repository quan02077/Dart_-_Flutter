import 'package:flutter/material.dart';

class Bai1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List view'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 100,
        itemBuilder: (context, i) {
          return ListTile(
            leading: const Icon(Icons.mail),
            title: Text('Item $i'),
            subtitle: Text('Item $i'),
            trailing: const Text('150.000đ'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 10),
      ),
    );
  }
}
