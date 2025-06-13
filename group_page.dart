import 'package:flutter/material.dart';
import 'chat_room_page.dart';

/// 群組頁面
class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  // 模擬群組聊天資料
  final List<GroupChat> groupChats = const [
    GroupChat(
      name: 'Jordan一家親(32)',
      lastMessage: '好酷哦😺😺😺',
      time: '7:05AM',
      unreadCount: 5,
      avatarColor: Colors.purple,
    ),
    GroupChat(
      name: '台北大咖們(103)',
      lastMessage: '好笑',
      time: '11:05AM',
      unreadCount: 10,
      avatarColor: Colors.green,
    ),
    GroupChat(
      name: '全桃聯對料(5)',
      lastMessage: '分享—跟團用。',
      time: '1:00AM',
      unreadCount: 0,
      avatarColor: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('群組 總'),
        backgroundColor: const Color(0xFFFDF6EC), // 米色背景
        elevation: 0,
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
      ),
      body: ListView.builder(
        itemCount: groupChats.length,
        itemBuilder: (context, index) {
          final chat = groupChats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: chat.avatarColor,
              radius: 24,
            ),
            title: Text(
              chat.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(chat.lastMessage),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  chat.time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (chat.unreadCount > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      chat.unreadCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoomPage(groupName: chat.name),
                  ),
                );
              }

          );
        },
      ),
      backgroundColor: const Color(0xFFFDF6EC), // 米色背景
    );
  }
}

/// 群組聊天模型
class GroupChat {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final Color avatarColor;

  const GroupChat({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatarColor,
  });
}