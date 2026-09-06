import 'dart:async';

class Cart {
  final Map<String, int> _prices;

  Cart(this._prices, this._items);

  Map<String, int> _items;

  int get total {
    int total = 0;
    _items.forEach((key, value) {
      total += _prices[key]! * value;
    });
    return total;
  }

  void add(String sku, int quantity) {
    if (quantity <= 0) {
      throw Exception('Số lượng phải lớn hơn 0');
    }
    if (!_prices.containsKey(sku)) {
      throw Exception('Sản phẩm không tồn tại');
    }
    _items[sku] = (_items[sku] ?? 0) + quantity;
    _events.add(CartEvent(sku, _items[sku]!, total));
  }

  final _events = StreamController<CartEvent>.broadcast();

  Stream<CartEvent> get events => _events.stream;

  Future<void> dispose() => _events.close();
}

class CartEvent {
  final String sku;
  final int quantity;
  final int total;

  CartEvent(this.sku, this.quantity, this.total);

  @override
  String toString() => '$sku x$quantity, tổng $total đ';
}

Stream<String> orderProgress(String orderId) async* {
  for (final step in ['Chờ xác nhận', 'Đã xác nhận', 'Đang giao', 'Đã giao']) {
    await Future.delayed(const Duration(milliseconds: 10));
    yield '$orderId: $step';
  }
}

void main() async {
  final cart = Cart({'AO-01': 150000, 'QU-01': 320000, 'NO-01': 890000}, {});

  final badge = cart.events
      .map((e) => e.total)
      .distinct()
      .listen(
        (t) => print('  [badge] $t đ'),
        onError: (Object err) => print('  [badge] bỏ qua lỗi: $err'),
      );

  final alerts = cart.events
      .where((e) => e.total >= 500000)
      .listen(
        (e) => print('  [cảnh báo] đơn lớn: $e'),
        onError: (Object err) => print('  [cảnh báo] bỏ qua lỗi: $err'),
      );

  cart.add('AO-01', 2);
  cart.add('QU-01', 1);
  cart.add('KHONG-CO', 1);
  cart.add('NO-01', 1);

  await Future.delayed(Duration.zero);

  await badge.cancel();
  await alerts.cancel();
  await cart.dispose();

  print('Tiến trình đơn:');
  await for (final step in orderProgress('DH-001')) {
    print('  $step');
  }

  print('Chỉ xem 2 bước đầu của đơn khác:');
  var seen = 0;
  await for (final step in orderProgress('DH-002')) {
    print('  $step');
    if (++seen == 2) break;
  }
  print('Đã dừng theo dõi');
}
