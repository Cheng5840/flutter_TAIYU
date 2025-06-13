import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  final String groupName;
  const ChatRoomPage({super.key, required this.groupName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
        backgroundColor: const Color(0xFFFDF6EC),
      ),
      body: Column(
        children: [
          // 聊天訊息列表
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: _buildChatMessages(),
            ),
          ),

          // 輸入區
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF556B2F), // 深綠色背景
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.white),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5DC), // 淡黃色背景
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.keyboard_voice, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFFDF6EC),
    );
  }

  // 根據群組名稱返回不同的聊天內容
  List<Widget> _buildChatMessages() {
    switch (groupName) {
      case 'Jordan一家親(32)':
        return _buildJordanFamilyMessages();
      case '台北大咖們(103)':
        return _buildTaipeiMessages();
      case '全桃聯對料(5)':
        return _buildTaoyuanMessages();
      default:
        return _buildDefaultMessages();
    }
  }

  // Jordan一家親的聊天內容
  List<Widget> _buildJordanFamilyMessages() {
    return [
      _buildOtherMessage(
        name: "Jordan01",
        avatarPath: "assets/jordan01_avatar.png",
        message: "這是我做的梗圖，快來看覓～",
      ),
      _buildOtherMessage(
        name: "Jordan本體",
        avatarPath: "assets/jordan_avatar.png",
        message: "",
        hasImage: true,
        imagePath: "assets/meme1.png",
        imageText: "",
        // loveCount: 1,
        // sadCount: 12,
      ),
      const SizedBox(height: 16),
      _buildOtherMessage(
        name: "Jordan01",
        avatarPath: "assets/jordan01_avatar.png",
        message: "好讚喔😂😂😂😂😂",
      ),
      const SizedBox(height: 16),
      _buildMyMessage(
        message: "天壽讚喔，繼續努力",
      ),
      const SizedBox(height: 16),
      _buildOtherMessage(
        name: "Jordan01",
        avatarPath: "assets/profile.png",
        message: "",
        hasImage: true,
        imagePath: "assets/meme2.png",
        imageText: "",
      ),
    ];
  }

  // 台北大咖們的聊天內容
  List<Widget> _buildTaipeiMessages() {
    return [
      _buildOtherMessage(
        name: "台北小王",
        avatarPath: "assets/profile1.png",
        message: "今天天氣真好耶！",
      ),
      const SizedBox(height: 16),
      _buildOtherMessage(
        name: "大咖阿明",
        avatarPath: "assets/taipei_user2.png",
        message: "要不要一起去信義區逛街？",
      ),
      const SizedBox(height: 16),
      _buildMyMessage(
        message: "好啊！幾點集合？",
      ),
      const SizedBox(height: 16),
      _buildOtherMessage(
        name: "台北小美",
        avatarPath: "assets/taipei_user3.png",
        message: "我也要去！",
      ),
      const SizedBox(height: 16),
      _buildOtherMessage(
        name: "大咖阿明",
        avatarPath: "assets/taipei_user2.png",
        message: "那就下午2點在信義誠品門口見面吧",
      ),
    ];
  }

  // 全桃聯對料的聊天內容
  List<Widget> _buildTaoyuanMessages() {
    return [
      _buildOtherMessage(
        name: "桃園老大",
        avatarPath: "assets/taoyuan_user1.png",
        message: "大家好，歡迎加入全桃聯對料群組！",
      ),
      const SizedBox(height: 16),
      _buildOtherMessage(
        name: "桃園小弟",
        avatarPath: "assets/taoyuan_user2.png",
        message: "謝謝老大！請多指教",
      ),
      const SizedBox(height: 16),
      _buildMyMessage(
        message: "大家好！",
      ),
      const SizedBox(height: 16),
      _buildOtherMessage(
        name: "桃園老大",
        avatarPath: "assets/profile3.png",
        message: "",
        hasImage: true,
        imagePath: "assets/meme2.png",
      ),
    ];
  }

  // 預設聊天內容（如果群組名稱不匹配）
  List<Widget> _buildDefaultMessages() {
    return [
      _buildOtherMessage(
        name: "系統訊息",
        avatarPath: "assets/system_avatar.png",
        message: "歡迎來到 $groupName 群組！",
      ),
      const SizedBox(height: 16),
      _buildMyMessage(
        message: "大家好！",
      ),
    ];
  }

  // 其他人的訊息（左側顯示）
  Widget _buildOtherMessage({
    required String name,
    required String avatarPath,
    required String message,
    bool hasImage = false,
    String? imagePath,
    String? imageText,
    bool hasReactions = false,
    int loveCount = 0,
    int sadCount = 0,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 頭像
        CircleAvatar(
          backgroundImage: AssetImage(avatarPath),
          radius: 20,
        ),
        const SizedBox(width: 12),
        // 對話框內容
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF8FBC8F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    if (hasImage && imagePath != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 250,
                                maxHeight: 250,
                              ),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            if (imageText != null && imageText.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  imageText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            // 播放按鈕圖示（如果需要）
                            const Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    if (hasReactions || loveCount > 0 || sadCount > 0)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            if (loveCount > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.favorite, color: Colors.red, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      loveCount.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (sadCount > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.sentiment_dissatisfied, color: Colors.yellow, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      sadCount.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 自己的訊息（右側顯示）
  Widget _buildMyMessage({
    required String message,
    bool hasImage = false,
    String? imagePath,
    String? imageText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 對話框內容
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: const Color(0xFF8FBC8F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                if (hasImage && imagePath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                            maxWidth: 250,
                            maxHeight: 200,
                          ),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        if (imageText != null && imageText.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              imageText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // 自己的頭像
        const CircleAvatar(
          backgroundImage: AssetImage("assets/my_avatar.png"),
          radius: 20,
        ),
      ],
    );
  }
}