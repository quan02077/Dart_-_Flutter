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

    bool isSymmetric = true;

    for (int i = 0; i < randomList.length / 2; i++) {
      if (randomList[i] != randomList[randomList.length - 1 - i]) {
        isSymmetric = false;
        break;
      }
    }

    if (isSymmetric) {
      print("Mang nay la mang doi xung!");
    } else {
      print("Mang nay KHONG PHAI la mang doi xung!");
    }

    bool isSortedAsc = true;

    for (int i = 0; i < randomList.length - 1; i++) {
      if (randomList[i] > randomList[i + 1]) {
        isSortedAsc = false;
        break;
      }
    }

    if (isSortedAsc) {
      print("Mang duoc sap xep tang dan!");
    } else {
      print("Mang KHONG duoc sap xep tang dan!");
    }

    int maxI = randomList.reduce((prevI, currentI) => max(prevI, currentI));
    print("So lon nhat trong mang: ${maxI}");

    List<int> hasEven = randomList.where((so) => so.isEven).toList();
    if (hasEven.isNotEmpty) {
      int maxEven = hasEven.reduce((prevI, currentI) => max(prevI, currentI));
      print('So chan lon nhat: ${maxEven}');
    } else {
      print('Danh sach ko co so chan');
    }

    stdout.write('Nhap vao so bat ky: ');
    String? inputRandom = stdin.readLineSync();

    if (inputRandom != null && inputRandom.isNotEmpty) {
      int inputRandomInt = int.parse(inputRandom);

      int viTri = randomList.indexOf(inputRandomInt);
      if (viTri == -1) {
        print('Khong tim thay');
      } else {
        randomList.removeAt(viTri);
        print(randomList);
      }
    }
  }
}
