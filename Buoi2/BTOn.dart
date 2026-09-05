import 'dart:io';   

class HoaDon {
  String _maKhachHang = 'KH0000';
  String _tenKhachHang = '';
  int _soLuong = 0;
  double _giaBan = 0;

  String get maKhachHang => _maKhachHang;
  String get tenKhachHang => _tenKhachHang;
  int get soLuong => _soLuong;
  double get giaBan => _giaBan;

  set maKhachHang(String value) {
    RegExp regex = RegExp(r'^KH\d{4}$');
    if (!regex.hasMatch(value)) {
        throw Exception('Mã khách hàng không đúng định dạng KHxxxx (ví dụ: KH0002)');
    }
    _maKhachHang = value;
  }

  set tenKhachHang(String value){
    if(value == ''){
        throw Exception('Không được để trống Tên Khách Hàng');
    }
    _tenKhachHang = value;
  }

  set soLuong(int value){
    if(value <= 0){
        throw Exception('Số Lượng phải lớn hơn 0');
    }
    _soLuong = value;
  }

  set giaBan(double value){
    if(value <= 0){
        throw Exception('Giá Bán phải lớn hơn 0');
    }
    _giaBan = value;
  }

  static const double VAT = 0.1;

  HoaDon();

  HoaDon.fullInfo({
    required String maKhachHang,
    required String tenKhachHang,
    required int soLuong,
    required double giaBan,
  }) {
    this.maKhachHang = maKhachHang;
    this.tenKhachHang = tenKhachHang;
    this.soLuong = soLuong;
    this.giaBan = giaBan;
  }

  
  double chietKhau() => 0;

  double thanhTien() {
    double tienHang = soLuong * giaBan;
    double thueVAT = tienHang * VAT;
    double tienTroGia = (this is HoTro) ? (this as HoTro).troGia() : 0;
    return tienHang - chietKhau() - tienTroGia + thueVAT;
  }

  void nhapThongTin(){
    stdout.write('Nhập Mã Khách Hàng: ');
    maKhachHang = stdin.readLineSync()!;
    stdout.write('Nhập Tên Khách Hàng: ');
    tenKhachHang = stdin.readLineSync()!;
    stdout.write('Nhập Số Lượng: ');
    soLuong = int.parse(stdin.readLineSync()!);
    stdout.write('Nhập Giá Bán: ');
    giaBan = double.parse(stdin.readLineSync()!);
  }

  void inThongTin(){
    print('Mã Khách Hàng: $maKhachHang');
    print('Tên Khách Hàng: $tenKhachHang');
    print('Số Lượng: $soLuong');
    print('Giá Bán: $giaBan');
    print('Thành tiền: ${thanhTien()}');
  }
}

class KHCaNhan extends HoaDon implements HoTro{
  double khoangCachGiaoHang = 0;
  KHCaNhan();
  KHCaNhan.fullInfo({
  required String maKhachHang,
  required String tenKhachHang,
  required int soLuong,
  required double giaBan,
  required this.khoangCachGiaoHang,
}) : super.fullInfo(
        maKhachHang: maKhachHang,
        tenKhachHang: tenKhachHang,
        soLuong: soLuong,
        giaBan: giaBan,
      );

  @override
  double chietKhau() {
    double tongChietKhau = 0;
    if (soLuong >= 3) {
      tongChietKhau += soLuong * (giaBan * 0.05);
    }
    if (khoangCachGiaoHang < 10) {
      tongChietKhau += soLuong * 50000;
    }

    return tongChietKhau;
  }

  @override
  double troGia() {
    double troGiaSP = 0.02 * giaBan * soLuong;
    if(soLuong > 2){
        troGiaSP += 100000;
    }
    return troGiaSP;
  }

  @override
  void nhapThongTin() {
    super.nhapThongTin();
    stdout.write('Nhập Khoảng Cách Giao Hàng: ');
    khoangCachGiaoHang = double.parse(stdin.readLineSync()!);
  }

  @override
  void inThongTin() {
    print('Trợ giá: ${troGia()}');
    print('Khoảng Cách Giao Hàng: $khoangCachGiaoHang');
    super.inThongTin();
  }
}

class DaiLyCap1 extends HoaDon {
    int thoiGianHopTac = 0;
    DaiLyCap1();
    DaiLyCap1.fullInfo({
  required String maKhachHang,
  required String tenKhachHang,
  required int soLuong,
  required double giaBan,
  required this.thoiGianHopTac,
}) : super.fullInfo(
        maKhachHang: maKhachHang,
        tenKhachHang: tenKhachHang,
        soLuong: soLuong,
        giaBan: giaBan,
      );

  @override
  double chietKhau() {
    double tiLe = 0.3;
    if (thoiGianHopTac > 5) {
      tiLe += thoiGianHopTac * 0.01; 
    }

    if (tiLe > 0.35) {
      tiLe = 0.35;
    }
    return (soLuong * giaBan) * tiLe;
  }

  @override
  void nhapThongTin() {
    super.nhapThongTin();
    stdout.write('Nhập Thời Gian Hợp Tác: ');
    thoiGianHopTac = int.parse(stdin.readLineSync()!);
  }

  @override
  void inThongTin() {
    print('Thời Gian Hợp Tác: $thoiGianHopTac');
    super.inThongTin();
  }
}

class CongTy extends HoaDon implements HoTro{
    int soLuongNV = 0;
    CongTy();
    CongTy.fullInfo({
  required String maKhachHang,
  required String tenKhachHang,
  required int soLuong,
  required double giaBan,
  required this.soLuongNV,
}) : super.fullInfo(
        maKhachHang: maKhachHang,
        tenKhachHang: tenKhachHang,
        soLuong: soLuong,
        giaBan: giaBan,
      );

    @override 
    double chietKhau(){
        double tongChietKhau = 0;
        if (soLuongNV > 5000) {
            tongChietKhau = soLuong * giaBan * 0.07;
        } 
        else if (soLuongNV > 1000) {
            tongChietKhau = soLuong * giaBan * 0.05;
        }
        return tongChietKhau;
    }

    @override
    double troGia() {
        double troGiaSP = 120000.0 * soLuong;
        return troGiaSP;
    }

    @override
    void nhapThongTin() {
      super.nhapThongTin();
      stdout.write('Nhập Số Lượng Nhân Viên: ');
      soLuongNV = int.parse(stdin.readLineSync()!);
    }

    @override
    void inThongTin() {
      print('Trợ giá: ${troGia()}');
      print('Số Lượng Nhân Viên: $soLuongNV');
      super.inThongTin();
    }
}

abstract interface class HoTro {
  double troGia();
}

class DanhSachHoaDon{
    List<HoaDon> danhSachHoaDon = [];
    DanhSachHoaDon.empty();
    DanhSachHoaDon.fullInfo({required this.danhSachHoaDon});
    
    void add(HoaDon hoaDon){
        danhSachHoaDon.add(hoaDon);
    }
    
    void remove(HoaDon hoaDon){
        danhSachHoaDon.remove(hoaDon);
    }
    
    void update(HoaDon hoaDon){
        danhSachHoaDon[danhSachHoaDon.indexOf(hoaDon)] = hoaDon;
    }

    void printHoaDon(){
        for (var hoaDon in danhSachHoaDon) {
            hoaDon.inThongTin();
        }
    }

    double get tinhTongTien => danhSachHoaDon.fold(0.0, (sum, hoaDon) => sum + hoaDon.thanhTien());

    double get tinhTongTroGia => danhSachHoaDon
        .where((hoaDon) => hoaDon is HoTro)
        .fold(0.0, (sum, hoaDon) => sum + (hoaDon as HoTro).troGia());

    double get tinhTongChietKhauCongTy => danhSachHoaDon
        .where((hoaDon) => hoaDon is CongTy)
        .fold(0.0, (sum, hoaDon) => sum + (hoaDon as CongTy).chietKhau());

    void sapXep(){
        danhSachHoaDon.sort((a, b) {
            int compareSoLuong = a.soLuong.compareTo(b.soLuong);
            if (compareSoLuong != 0) {
                return compareSoLuong; 
            }
            return b.thanhTien().compareTo(a.thanhTien());
        });
    }

    void khachHangMuaNhieuNhat() {
    if (danhSachHoaDon.isEmpty) {
        print('Danh sách rỗng!');
        return;
    }
    var maxHD = danhSachHoaDon.reduce((a, b) => a.soLuong > b.soLuong ? a : b);
    print('--- KHÁCH HÀNG MUA NHIỀU NHẤT ---');
    maxHD.inThongTin();
}


    void timKiem(String x) {
      bool timThay = false;
      for (var hoaDon in danhSachHoaDon) {
        if (hoaDon.maKhachHang == x) {
          hoaDon.inThongTin();
          timThay = true;
        }
      }
      if (!timThay) {
          print("Khách hàng lạ");
      }
    }
}

void main() {
    var dsHoaDon = DanhSachHoaDon.empty();
    
    // Dùng constructor fullInfo để tạo sẵn dữ liệu mẫu (chạy là ra kết quả ngay, không cần gõ tay):
    var khCaNhan = KHCaNhan.fullInfo(
      maKhachHang: 'KH0001',
      tenKhachHang: 'Minh Quân',
      soLuong: 5,
      giaBan: 1000000,
      khoangCachGiaoHang: 8,
    );

    var daiLyCap1 = DaiLyCap1.fullInfo(
      maKhachHang: 'KH0002',
      tenKhachHang: 'Đại Lý Á Châu',
      soLuong: 20,
      giaBan: 900000,
      thoiGianHopTac: 6,
    );

    var congTy = CongTy.fullInfo(
      maKhachHang: 'KH0003',
      tenKhachHang: 'Công Ty ABC Tech',
      soLuong: 15,
      giaBan: 1000000,
      soLuongNV: 2500,
    );

    // Nếu muốn tự nhập tay từ bàn phím thì bỏ comment 3 dòng dưới này nhé:
    khCaNhan.nhapThongTin();
    daiLyCap1.nhapThongTin();
    congTy.nhapThongTin();

    dsHoaDon.add(khCaNhan);
    dsHoaDon.add(daiLyCap1);
    dsHoaDon.add(congTy);

    print('\n=== DANH SÁCH HÓA ĐƠN ===');
    dsHoaDon.printHoaDon();

    print('\nTổng thành tiền: ${dsHoaDon.tinhTongTien}');
    print('Tổng trợ giá công ty hỗ trợ: ${dsHoaDon.tinhTongTroGia}');
    print('Tổng chiết khấu cho khách hàng công ty: ${dsHoaDon.tinhTongChietKhauCongTy}');

    print('\n=== KHÁCH HÀNG MUA NHIỀU NHẤT ===');
    dsHoaDon.khachHangMuaNhieuNhat();

    print('\n=== DANH SÁCH SAU KHI SẮP XẾP ===');
    dsHoaDon.sapXep();
    dsHoaDon.printHoaDon();

    print('\n=== TÌM KIẾM HÓA ĐƠN ===');
    stdout.write('Nhập mã khách hàng cần tìm: ');
    String ma = stdin.readLineSync()!.trim();
    dsHoaDon.timKiem(ma);
}


