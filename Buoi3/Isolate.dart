import 'dart:async';
import 'dart:isolate';

// Hàm chạy bên trong Isolate phụ
void backgroundWorker(SendPort mainSendPort) {
  // 1. Tạo ReceivePort riêng cho Isolate phụ để nhận tin nhắn từ Main
  ReceivePort workerReceivePort = ReceivePort();

  // 2. Gửi SendPort của Isolate phụ về cho Main Isolate biết địa chỉ
  mainSendPort.send(workerReceivePort.sendPort);

  // 3. Lắng nghe công việc từ Main Isolate gửi sang
  workerReceivePort.listen((message) {
    if (message is List) {
      String command = message[0];
      int data = message[1];

      if (command == 'SQUARE') {
        int result = data * data;
        // Gửi kết quả ngược lại cho Main Isolate
        mainSendPort.send('Kết quả bình phương $data là: $result');
      }
    } else if (message == 'CLOSE') {
      workerReceivePort.close(); // Đóng cổng nhận
    }
  });
}

void main() async {
  // 1. Tạo ReceivePort ở Main Isolate
  ReceivePort mainReceivePort = ReceivePort();

  // 2. Khởi tạo Isolate phụ và truyền SendPort của Main sang cho nó
  Isolate workerIsolate = await Isolate.spawn(
    backgroundWorker,
    mainReceivePort.sendPort,
  );

  // Biến lưu SendPort của Isolate phụ để gửi lệnh sau này
  late SendPort workerSendPort;

  // 3. Lắng nghe dữ liệu gửi về từ Isolate phụ
  mainReceivePort.listen((message) {
    if (message is SendPort) {
      // Nhận được SendPort của Isolate phụ
      workerSendPort = message;
      print('[Main] Đã kết nối thành công với Isolate phụ!');

      // Gửi nhiệm vụ tính toán sang Isolate phụ
      workerSendPort.send(['SQUARE', 12]);
    } else {
      // Nhận kết quả tính toán
      print('[Main] Nhận phản hồi: $message');

      // Xử lý xong thì dọn dẹp
      workerSendPort.send('CLOSE');
      mainReceivePort.close();
      workerIsolate.kill(priority: Isolate.immediate);
      print('[Main] Đã đóng Isolate phụ.');
    }
  });
}
