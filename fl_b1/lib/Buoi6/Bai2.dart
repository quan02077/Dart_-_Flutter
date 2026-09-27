import 'package:flutter/material.dart';
class Bai2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid view'),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
        itemCount: 100,
        itemBuilder: (context, i){
            return Container(
              decoration: BoxDecoration(
                color: (i ~/ 2 + i % 2).isEven ? Colors.teal.shade100 : Colors.teal.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text('Item $i', style: const TextStyle(fontWeight: FontWeight.bold),),
            );
        },
      )
    );
  }
}
