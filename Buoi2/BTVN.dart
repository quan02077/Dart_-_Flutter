enum CupSize {
  small(extra: 0.0),
  medium(extra: 5000.0),
  large(extra: 10000.0);

  final double extra;
  CupSize({required this.extra});

  double extraPrice() => extra;
}

mixin Discountable {
  double applyDiscount(double originalPrice, double percent) {
    return originalPrice * (1 - percent / 100);
  }
}

abstract class Drink {
  final String id;
  final String name;
  double _basePrice;

  Drink({required this.id, required this.name, required double basePrice})
    : _basePrice = basePrice;

  set basePrice(double value) {
    if (value < 0) {
      throw ArgumentError('Base price cannot be negative');
    }
    _basePrice = value;
  }

  double get basePrice => _basePrice;

  double calculatePrice(CupSize size, {bool isMember = false});
}

class Coffee extends Drink with Discountable {
  final bool isIced;

  Coffee({
    required String id,
    required String name,
    required double basePrice,
    this.isIced = false,
  }) : super(id: id, name: name, basePrice: basePrice);

  @override
  double calculatePrice(CupSize size, {bool isMember = false}) {
    double price = basePrice + size.extraPrice();
    if (isMember) {
      price = applyDiscount(price, 10);
    }
    return price;
  }
}

class FruitTea extends Drink with Discountable {
  final bool hasTopping;

  FruitTea({
    required String id,
    required String name,
    required double basePrice,
    this.hasTopping = false,
  }) : super(id: id, name: name, basePrice: basePrice);

  @override
  double calculatePrice(CupSize size, {bool isMember = false}) {
    double price = basePrice + size.extraPrice();
    if (hasTopping) {
      price += 6000.0;
    }
    return price;
  }
}

class OrderItem {
  final Drink drink;
  final CupSize size;

  OrderItem(this.drink, this.size);
}

class Order {
  // 1. Thuộc tính private lưu danh sách món
  final List<OrderItem> _items = [];

  // 2. Hàm thêm món vào đơn
  void addDrink(Drink drink, CupSize size) {
    _items.add(OrderItem(drink, size));
    print('Đã thêm ${drink.name} (size ${size.name}) vào đơn hàng.');
  }

  double get totalAmount => _items.fold(
    0.0,
    (sum, item) => sum + item.drink.calculatePrice(item.size),
  );
}

extension CurrencyFormat on double {
  String get inVND {
    final digits = abs().toInt().toString();
    final out = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) out.write('.');
      out.write(digits[i]);
    }
    return '${isNegative ? '-' : ''}$out đ';
  }
}

void main() {
  // 1. Tạo các món uống
  final cf = Coffee(
    id: 'CF01',
    name: 'Cà phê muối',
    basePrice: 30000.0,
    isIced: true,
  );

  final traDao = FruitTea(
    id: 'TE01',
    name: 'Trà đào cam sả',
    basePrice: 35000.0,
    hasTopping: true,
  );

  // 2. Tạo đơn hàng và thêm món
  final order = Order();
  order.addDrink(cf, CupSize.medium); // 30.000 + 5.000 = 35.000
  order.addDrink(
    traDao,
    CupSize.large,
  ); // 35.000 + 10.000 + 6.000 (topping) = 51.000

  // 3. In kết quả
  print('Tổng tiền đơn hàng: ${order.totalAmount.inVND}');
  // Kết quả kỳ vọng: 86.000 đ

  // 4. Test mixin giảm giá cho riêng cà phê
  final giaSauGiam = cf.applyDiscount(
    cf.calculatePrice(CupSize.medium),
    10,
  ); // Giảm 10%
  print('Cà phê muối size M sau giảm 10%: ${giaSauGiam.inVND}');
  // Kết quả kỳ vọng: 31.500 đ
}
