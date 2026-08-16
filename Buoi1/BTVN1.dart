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

    int sum = randomList.reduce((prevI, currentI) => prevI + currentI);
    print('Tong: ${sum}');

    List<int> hasOdd = randomList.where((so) => so.isOdd).toList();
    if (hasOdd.isNotEmpty) {
      int total = hasOdd.reduce((prevI, currentI) => prevI + currentI);
      double tbc = total / hasOdd.length;
      print("Trung binh cong so le: ${tbc.toStringAsFixed(2)}");
    } else {
      print("Danh sach ko co so le");
    }
  }
}
