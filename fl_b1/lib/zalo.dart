import 'package:flutter/material.dart';

class ChatItem {
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isGroupIcon;

  const ChatItem({
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isGroupIcon = false,
  });
}

class ZaloScreen extends StatelessWidget {
  final List<ChatItem> _chats = [
    ChatItem(
      name: 'Nguyễn Văn A',
      message: 'Hẹn gặp tối nay nhé!',
      time: '14:15',
      unreadCount: 3,
    ),
    ChatItem(
      name: 'Gia đình ❤️',
      message: 'Mẹ: Bố về chưa?',
      time: '14:10',
    ),
    ChatItem(
      name: 'Gia đình',
      message: 'Mẹ: Bố về chưa?',
      time: '14:10',
    ),
    ChatItem(
      name: 'Trần Thị B',
      message: 'Okay, gửi mình link đi',
      time: '13:45',
    ),
    ChatItem(
      name: 'Nguyễn Dann',
      message: 'Hẹm giao nay!',
      time: '13:45',
      unreadCount: 4,
    ),
    ChatItem(
      name: 'Thar Nguyễn',
      message: 'Okay, gặp tối cảm đờ dấn',
      time: '13:30',
      unreadCount: 2,
    ),
    ChatItem(
      name: 'Thân Con',
      message: 'Mhh, và ung rân mình bệ điển đ...',
      time: '12:18',
      unreadCount: 3,
    ),
    ChatItem(
      name: 'Vinh Kiện',
      message: 'Hẹn gặp tối nay!',
      time: '02:29',
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Zalo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
            Text('Tin nhắn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          ],
        ),
        actions: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                const Text('Tìm kiếm', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                const Text('Thêm', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
                  const Text('Cài đặt', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: _chats.length,
        itemBuilder: (context, i) {
          final chat = _chats[i];

          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  "hinh_anh/Sau.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            title: Text(
              chat.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Text(
              chat.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(chat.time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                if (chat.unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${chat.unreadCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Tin nhắn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page_outlined),
            label: 'Danh bạ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Nhật ký',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Thêm',
          ),
        ],
      ),

    );
  }
}