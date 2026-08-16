import 'dart:io';
void main() {
Bai1();
}

void Bai1(){
  stdout.write('Nhap so que kem: ');
  String? soQueKem_input = stdin.readLineSync();
  stdout.write('Nhap don gia: ');
  String? donGia_input = stdin.readLineSync();

  try{
      if((soQueKem_input != null && soQueKem_input.isNotEmpty) && (donGia_input != null && donGia_input.isNotEmpty)){
      int soQueKemInt = int.parse(soQueKem_input);
      int donGiaInt = int.parse(donGia_input);
      int tongTien = soQueKemInt * donGiaInt;
          if(soQueKemInt > 0){
            if(soQueKemInt < 5){
              print("Tong tien: ${tongTien}");
            }
            else if(soQueKemInt >= 5 && soQueKemInt <= 10){
              print("Tong tien: ${tongTien * 0.95}");
            }
            else{
              print("Tong tien: ${tongTien * 0.9}");
            }
        }
        else{
          print("So que kem phai lon hon 0");
        }
    }
  }catch(e){
    print('Nhap wrong roi ${e.toString()}');
  }
}