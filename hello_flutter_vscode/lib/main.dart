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
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                MyText(["Nguyen Van A"]),
                DemoStatefulWidget(),
                Image.asset("hinh_anh/images.jpg", width: 200, height: 200),
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final List<String> name;
  MyText(this.name);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Xin chào!"),
        ...name
            .map(
              (name) => Text(
                "Toi la $name",
                style: const TextStyle(color: Colors.blue),
              ),
            )
            .toList(),
      ],
    );
  }
}

class DemoStatefulWidget extends StatefulWidget {
  @override
  State<DemoStatefulWidget> createState() {
    return CountStatefulWidget();
  }
}

class CountStatefulWidget extends State<DemoStatefulWidget> {
  int dem = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("So lan nhan: $dem"),
        ElevatedButton(
          onPressed: () {
            dem++;
            setState(() {});
          },
          child: const Text("Nhan vao day"),
        ),
      ],
    );
  }
}
