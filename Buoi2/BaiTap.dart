import 'dart:math';

class Product {
  final String name;
  final double price;
  final int stock;

  Product({required this.name, required this.price, required this.stock});

  bool isAvailable() => stock > 0;
}

class CartItem {
  String productId;
  String name;
  double lockedPrice;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.lockedPrice,
    required this.quantity,
  });
}

class Cart {
  // QUYẾT ĐỊNH THIẾT KẾ 2: Giá lưu ở đâu?
  // Lý do: Hiện tại bài tập đang lưu Tham chiếu (gọi thẳng list Product).
  // Tuy nhiên tôi nhận thức được rủi ro: Nếu admin đổi giá Product, giỏ hàng sẽ bị đổi giá theo.
  // Giải pháp thực tế (nếu làm app thật): Tôi sẽ tạo một class CartItem để "chép cứng" (copy)
  // giá tiền ngay tại thời điểm khách bấm nút Add to Cart.
  final List<CartItem> _cartItems = [];

  // QYẾT ĐỊNH THIẾT KẾ 1: Quản lý hết hàng
  // Lý do: Tôi chọn cách ném ra lỗi (throw Exception) thay vì trả về false.
  // Vì nếu trả false, người gọi code có thể quên kiểm tra (if).
  // Ném lỗi sẽ làm ứng dụng dừng lại ngay, ép lập trình viên phải viết code xử lý (try-catch).
  void add(Product product) {
    if (!product.isAvailable()) {
      throw Exception(
        'Sản phẩm ${product.name} đã hết hàng!',
      ); // Sửa print thành throw
    }
    var newItem = CartItem(
      productId: product.name,
      name: product.name,
      lockedPrice: product.price,
      quantity: 1,
    );
    _cartItems.add(newItem);
  }

  void remove(Product product) {
    var itemToRemove = _cartItems.firstWhere(
      (item) => item.productId == product.name,
      orElse: () =>
          throw Exception('Sản phẩm ${product.name} không có trong giỏ hàng.'),
    );
    _cartItems.remove(itemToRemove);
    print('${product.name} đã được xóa khỏi giỏ hàng.');
  }

  double get total =>
      _cartItems.fold(0.0, (a, b) => a + b.lockedPrice * b.quantity);

  int get count => _cartItems.length;
}

class Customer {
  double getDiscount() => 0.0;

  double calculateTotal(double total) {
    return total - (total * getDiscount());
  }
}

// QUYẾT ĐỊNH THIẾT KẾ 3: Kế thừa hay Thuộc tính?
// Lý do: Bài này tôi dùng Kế thừa (extends) vì mục đích chính là để thực hành Đa hình (Polymorphism).
// Nhưng trong app thực tế, do khách thường và VIP chỉ khác nhau mỗi con số phần trăm,
// tôi sẽ không đẻ thêm class mới mà chỉ dùng 1 class Customer có thêm biến `double mucGiamGia` cho nhẹ máy.
class VipCustomer extends Customer {
  @override
  double getDiscount() => 0.5;
}

abstract class Discount {
  double tinhGiamGia(double tongTien);
}

class GiamTran extends Discount {
  final double phanTram;
  final double tranGiam;

  GiamTran(this.phanTram, this.tranGiam);

  @override
  double tinhGiamGia(double tongTien) {
    double giamGia = tongTien * phanTram;
    return min(giamGia, tranGiam);
  }
}

class GiamNguong extends Discount {
  final double soTienGiam;
  final double nguong;

  GiamNguong(this.soTienGiam, this.nguong);

  @override
  double tinhGiamGia(double tongTien) {
    if (tongTien >= nguong) {
      return soTienGiam;
    } else {
      return 0.0;
    }
  }
}

Discount? chonGiamGia(List<Discount> danhSachGiamGia, double tongTien) {
  if (danhSachGiamGia.isEmpty) return null;

  return danhSachGiamGia.reduce((bestRule, currentRule) {
    return currentRule.tinhGiamGia(tongTien) > bestRule.tinhGiamGia(tongTien)
        ? currentRule
        : bestRule;
  });
}

extension VndFormat on double {
  String get vnd {
    final digits = abs().toInt().toString();
    final out = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) out.write('.');
      out.write(digits[i]);
    }
    return '${isNegative ? '-' : ''}$out đ';
  }
}

enum ShipMethod {
  tieuChuan(phi: 10000.0, thoiGian: 5),
  nhanh(phi: 20000.0, thoiGian: 2);

  final double phi;
  final int thoiGian;

  const ShipMethod({required this.phi, required this.thoiGian});

  String get moTa => 'Phí: ${phi.vnd}, Thời gian: $thoiGian ngày';
}

// Chữ "sealed" nghĩa là "Niêm phong".
// Nghĩa là gia đình PaymentStatus này chỉ có những đứa con được viết trong file này thôi,
// tuyệt đối không ai được đẻ thêm class con ở file khác.
sealed class PaymentStatus {}

// Trạng thái 1: Đang chờ (Không cần dữ liệu gì thêm)
class Pending extends PaymentStatus {}

// Trạng thái 2: Thành công (Mang theo mã giao dịch để in biên lai)
class Success extends PaymentStatus {
  final String transactionId;
  Success(this.transactionId);
}

// Trạng thái 3: Thất bại (Mang theo lý do lỗi để báo cho khách)
class Failure extends PaymentStatus {
  final String errorMessage;
  Failure(this.errorMessage);
}

class Refunded extends PaymentStatus {}

void inKetQuaThanhToan(PaymentStatus status) {
  // Lệnh switch này không hề có chữ "default"
  switch (status) {
    case Pending():
      print('Đang xoay vòng vòng... Vui lòng chờ.');
      break;
    case Success(
      transactionId: var id,
    ): // Vừa check trạng thái, vừa lôi mã giao dịch ra xài luôn!
      print('Tiền đã vào túi! Mã giao dịch của bạn là: $id');
      break;
    case Failure(errorMessage: var loi): // Lôi lý do lỗi ra
      print('Thanh toán tạch rồi, lý do: $loi');
      break;
    case Refunded():
      print('Đơn hàng đã được hoàn tiền.');
      break;
  }
}

void main() {
  // var product1 = Product(name: 'Iphone 14', price: 2000, stock: 10);
  // var cart = Cart();
  // cart.add(product1);
  // print('Tổng tiền: ${cart.total}');
  // print('Số lượng sản phẩm trong giỏ hàng: ${cart.count}');
  // cart.remove(product1);
  // print('Số lượng sản phẩm trong giỏ hàng: ${cart.count}');

  // var thuong = Customer();
  // var vip = VipCustomer();
  // print('Khách thường mua 100k, phải trả: ${thuong.calculateTotal(100).vnd}');
  // print('Khách VIP mua 100k, phải trả: ${vip.calculateTotal(100).vnd}');

  // var km1 = GiamTran(0.1, 50);
  // var km2 = GiamNguong(30, 200);
  // var danhSachKhuyenMai = [km1, km2];
  // var chonKMTotNhat = chonGiamGia(danhSachKhuyenMai, 100);
  // print('Đơn 100k giảm lớn nhất là: ${chonKMTotNhat!.tinhGiamGia(100)}k');

  // var chonKMTotNhat2 = chonGiamGia(danhSachKhuyenMai, 250);
  // print('Đơn 250k giảm lớn nhất là: ${chonKMTotNhat2!.tinhGiamGia(250)}k');

  //main
  var product1 = Product(name: 'Iphone 14', price: 2000, stock: 10);
  var product2 = Product(name: 'Samsung Galaxy S23', price: 1800, stock: 5);
  var product3 = Product(name: 'Xiaomi Mi 12', price: 1500, stock: 0);

  var cart = Cart();
  cart.add(product1);
  cart.add(product2);
  try {
    cart.add(product3);
  } catch (e) {
    print(
      'LỖI KHÔNG THỂ THÊM: $e',
    ); // In báo lỗi cho khách xem, rồi code vẫn vui vẻ chạy tiếp phần dưới!
  } // Sản phẩm hết hàng

  double tongTien = cart.total;
  print('Tổng tiền: ${cart.total.vnd}');
  print('Số lượng sản phẩm trong giỏ hàng: ${cart.count}');

  try {
    cart.remove(product3);
  } catch (e) {
    print('LỖI KHÔNG THỂ XÓA: $e');
  }
  print('Số lượng sản phẩm trong giỏ hàng: ${cart.count}');

  var thuong = Customer();
  var vip = VipCustomer();
  print(
    'Khách thường mua ${cart.total.vnd}, phải trả: ${thuong.calculateTotal(tongTien).vnd}',
  );
  print(
    'Khách VIP mua ${cart.total.vnd}, phải trả: ${vip.calculateTotal(tongTien).vnd}',
  );

  var km1 = GiamTran(0.1, 50);
  var km2 = GiamNguong(30, 200);

  var danhSachKhuyenMai = [km1, km2];
  var chonKMTotNhat = chonGiamGia(danhSachKhuyenMai, tongTien);
  print(
    'Đơn ${cart.total.vnd} giảm lớn nhất là: ${chonKMTotNhat!.tinhGiamGia(tongTien).vnd}',
  );

  print('Phương thức vận chuyển tiêu chuẩn: ${ShipMethod.tieuChuan.moTa}');
  print('Phương thức vận chuyển nhanh: ${ShipMethod.nhanh.moTa}');

  print(
    'Tổng tiền sau khi áp dụng khuyến mãi và phí vận chuyển tiêu chuẩn: ${(tongTien - chonKMTotNhat.tinhGiamGia(tongTien) + ShipMethod.tieuChuan.phi).vnd}',
  );

  var trangThaiHienTai = Failure('Ngân hàng đang bảo trì');
  inKetQuaThanhToan(trangThaiHienTai);
}
