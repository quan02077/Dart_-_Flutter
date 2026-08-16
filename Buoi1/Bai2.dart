import 'dart:io';
import 'dart:math';

void main(){
Bai2();
}

void Bai2(){
  stdout.write("Nhap so nguyen > 10: ");
  String? soNguyen = stdin.readLineSync();

  if(soNguyen != null && soNguyen.isNotEmpty){
    print('So nguyen co ${soNguyen.length} chu so');

    List<String> chuSo = soNguyen.split('');
    List<int> chuSoInt = chuSo.map((item) => int.parse(item)).toList();
    int total = 0;
    int count = 0;
    int max = 0;
    bool checkPrime = false;
    for(int i in chuSoInt){
      total += i;
      if(i % 2 != 0){
        count=i;
      }
      if(i > max){
        max = i;
      }

      bool isCurrentPrime = true;
      if(i < 2) {
        isCurrentPrime = false;
      }
      for(int k =2; k <= sqrt(i); k++){
        if(i % k == 0){
          isCurrentPrime = false;
          break;
        }
      }
      if(isCurrentPrime){
        checkPrime = true;
      }
    }
    print("Tong chu so: ${total}");
    if(count != 0){
      print("So nguyen co so le");
    }
    else{
      print("So nguyen khong co so le");
    }
    print("Chu so lon nhat: ${max}");
    if(checkPrime){
      print("So nguyen co chua so nguyen to");
    }
    else{
      print("So nguyen khong chua so nguyen to");
    }
  }
}