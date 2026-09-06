import 'dart:async';

Future<String> endpoint(String path, int ms, {bool fail = false}) async {
  await Future.delayed(Duration(milliseconds: ms));
  if (fail) {
    throw Exception("Không thể kết nối tới đường dẫn này");
  }
  return path;
}

Future<List<String>> loadHomeParallel() async {
  return await Future.wait([
    endpoint('home/banner', 1000),
    endpoint('home/feature', 2000),
    endpoint('home/recommend', 3000),
  ]);
}

Future<List<String>> loadHomeResilient() async {
  return await Future.wait([
    endpoint('home/banner', 1000, fail: true).catchError((e) => 'home/banner'),
    endpoint(
      'home/feature',
      2000,
      fail: true,
    ).catchError((e) => 'home/feature'),
    endpoint('home/recommend', 3000),
  ]);
}

Future<String> fastestCdn() async {
  return await Future.any([
    endpoint('cdn-banner', 1000),
    endpoint('cdn-feature', 2000),
    endpoint('cdn-recommend', 3000),
  ]);
}

Future<void> notifyAll(List<String> emails) async {
  Future.forEach(emails, (String to) async {
    await Future.delayed(Duration(milliseconds: 1000));
    print('Đã gửi email tới $to');
  });
}

Future<String> withRetry(
  Future<String> Function() task, {
  required int remaining,
}) {
  return task().catchError((Object e) {
    if (remaining <= 0) throw e;
    print('    thất bại, còn $remaining lượt thử');
    return withRetry(task, remaining: remaining - 1);
  });
}

void main() async {
  print('Song song: ${await loadHomeParallel()}');
  print('Chịu lỗi:  ${await loadHomeResilient()}');
  print('CDN nhanh nhất: ${await fastestCdn()}');

  print('Gửi thông báo:');
  await notifyAll(['an@example.com', 'binh@example.com']);

  await withRetry(() {
    return endpoint('/orders', 10, fail: true);
  }, remaining: 2);
}
