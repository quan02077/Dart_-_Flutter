import "dart:async";
import "dart:isolate";

void pricingWorker(SendPort toMain) {
  ReceivePort workerReceivePort = ReceivePort();

  toMain.send(workerReceivePort.sendPort);

  workerReceivePort.listen((message) {
    if (message is List) {
      String sku = message[0];
      int basePrice = message[1];

      int calculatedPrice = basePrice;
      for (int i = 0; i < 50000000; i++) {
        calculatedPrice += (i % 2 == 0) ? 1 : -1;
      }
      calculatedPrice += (basePrice * 0.1).round();

      toMain.send((sku, calculatedPrice));
    } else if (message == 'CLOSE') {
      workerReceivePort.close();
    }
  });
}

class PricingService {
  late final Isolate _isolate;
  late final ReceivePort _mainPort;
  late final SendPort _workerSendPort;
  late final StreamIterator _iterator;

  static Future<PricingService> create() async {
    final service = PricingService();
    service._mainPort = ReceivePort();
    service._iterator = StreamIterator(service._mainPort);
    service._isolate = await Isolate.spawn(pricingWorker, service._mainPort.sendPort);

    await service._iterator.moveNext();
    service._workerSendPort = service._iterator.current as SendPort;

    return service;
  }

  Future<int> priceOf(String sku, int basePrice) async {
    _workerSendPort.send((sku, basePrice));

    await _iterator.moveNext();

    final (resSku, resPrice) = _iterator.current as (String, int);

    return resPrice;
  }

  Future<void> dispose() async {
    _workerSendPort.send('CLOSE');
    await _iterator.cancel();
    _mainPort.close();
    _isolate.kill();
  }
}

void main() async {
  final service = await PricingService.create();

  int tick = 0;
  final timer = Timer.periodic(Duration(milliseconds: 100), (_) {
    tick++;
    print('  [Main Thread đang chạy UI...] Tick: $tick');
  });

  final price1 = await service.priceOf('AO-01', 150000);
  print('=> Kết quả AO-01: $price1 đ');

  final price2 = await service.priceOf('QU-01', 320000);
  print('=> Kết quả QU-01: $price2 đ');

  timer.cancel();
  print('=> Số nhịp đồng hồ đã đếm được: $tick');
  await service.dispose();
}
