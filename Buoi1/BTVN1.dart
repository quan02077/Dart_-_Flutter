import 'dart:io';
import 'dart:math';

void main() {
  BTVN1();
}

void BTVN1() {
  stdout.write('Nhap so luong phan tu cua mang: ');
  String? input = stdin.readLineSync();

  if (input != null && input.isNotEmpty) {
    int inputInt = int.parse(input);

    final random = Random();
    List<int> randomList = List.generate(
      inputInt,
      (index) => random.nextInt(96) + 5,
    );

    print(randomList);
  }
}
