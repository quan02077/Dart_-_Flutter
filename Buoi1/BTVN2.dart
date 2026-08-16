import 'dart:io';

void main() {
  BTVN2();
}

void BTVN2() {
  stdout.write("Nhap vao mang so nguyen: ");
  String? input = stdin.readLineSync();

  if (input != null && input.isNotEmpty) {
    print("Chuoi vua nhap: ${input}");
    List<String> nguyenAm = ['u', 'e', 'o', 'a', 'i'];
    int count = input
        .toLowerCase()
        .split('')
        .where((kyTu) => nguyenAm.contains(kyTu))
        .length;
    print('So ky tu nguyen am: ${count}');
    print('Chuoi co ${input.length} tu');
    String reverseString = input.split('').reversed.join('');
    if (input.toLowerCase() == reverseString.toLowerCase()) {
      print('Chuoi doi xung');
    } else {
      print('Chuoi khong doi xung');
    }
    String revString = input.split(' ').reversed.join(' ');
    print(revString);
  }
}
