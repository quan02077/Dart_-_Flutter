import 'dart:io';
import 'dart:math';

void main(){
  Bai3();
}

    bool isPrime(int so){
    if(so < 2) return false;
    for(int i = 2; i <= sqrt(so); i++){
      if(so % i == 0) return false;
    }
    return true;
  }

void Bai3(){
  stdout.write("Nhap vao mang so nguyen: ");
  String? input = stdin.readLineSync();

  if(input != null && input.isNotEmpty){
    List<String> stringList = input.split(' ');
    List<int> intList = stringList.map(int.parse).toList();
    print("Mang vua nhap: ${intList}");

    int sum = intList.reduce((prevI, currentI) => prevI + currentI);
    print("Tong: ${sum}");

    List<int> primeList = intList.where((so) => isPrime(so)).toList();
    if(primeList.isNotEmpty){
      print("Mang co chua so nguyen to");
      print("So nguyen to: ${primeList}");
    }
    else{
      print("Mang khong co so nguyen to");
    }    
    stdout.write("Nhap vao so nguyen bat ky: ");
    String? inputRandom = stdin.readLineSync();
    if(inputRandom != null && inputRandom.isNotEmpty){
      int randomNum = int.parse(inputRandom);
      int viTri = intList.indexOf(randomNum);
      if(viTri == -1){
        print("So ${randomNum} chua co trong danh sach");
        intList.insert(0, randomNum);
        print(intList);
      }
      else{
        print("So ${randomNum} da co trong danh sach o vi tri ${viTri}");
      }
    }
  }
}