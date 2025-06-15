import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final String groupName;
  const ChatRoomPage({super.key, required this.groupName});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

// 訊息資料模型
class ChatMessage {
  final String id;
  final String message;
  final bool isMyMessage;
  final String? senderName;
  final String? avatarPath;
  final DateTime timestamp;
  final bool hasImage;
  final String? imagePath;
  final String? imageText;

  ChatMessage({
    String? id,
    required this.message,
    required this.isMyMessage,
    this.senderName,
    this.avatarPath,
    required this.timestamp,
    this.hasImage = false,
    this.imagePath,
    this.imageText,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _chatMessages = [];
  bool _isLoading = true;

  // 靜態存儲（內存中，應用重啟後會清空）
  static final Map<String, List<ChatMessage>> _memoryStorage = {};

  @override
  void initState() {
    super.initState();
    _loadChatData();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // 載入聊天資料（從內存）
  Future<void> _loadChatData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 從內存中載入資料
      if (_memoryStorage.containsKey(widget.groupName)) {
        _chatMessages = List.from(_memoryStorage[widget.groupName]!);
        print('從內存載入了 ${_chatMessages.length} 條訊息');
      } else {
        // 創建新的聊天室資料
        _chatMessages = _getInitialMessages();
        _memoryStorage[widget.groupName] = List.from(_chatMessages);
        print('創建新聊天室並載入 ${_chatMessages.length} 條初始訊息');
      }
    } catch (e) {
      print('載入聊天資料時發生錯誤: $e');
      _chatMessages = _getInitialMessages();
    }

    setState(() {
      _isLoading = false;
    });
  }

  // 保存聊天資料（到內存）
  Future<void> _saveChatData() async {
    try {
      _memoryStorage[widget.groupName] = List.from(_chatMessages);
      print('聊天資料已保存到內存');
      print('總共 ${_chatMessages.length} 條訊息');
    } catch (e) {
      print('保存聊天資料時發生錯誤: $e');
    }
  }

  // 發送訊息
  Future<void> _sendMessage() async {
    String message = _messageController.text.trim();
    print("嘗試發送訊息: '$message'");

    if (message.isNotEmpty) {
      final newMessage = ChatMessage(
        message: message,
        isMyMessage: true,
        timestamp: DateTime.now(),
      );

      setState(() {
        _chatMessages.add(newMessage);
      });

      // 保存到內存
      await _saveChatData();

      _messageController.clear();
      print("訊息已發送並保存，總共 ${_chatMessages.length} 個訊息");
    } else {
      print("訊息為空，未發送");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        backgroundColor: const Color(0xFFFDF6EC),
        actions: [
          // 重新載入按鈕
          // IconButton(
          //   icon: const Icon(Icons.refresh),
          //   onPressed: _loadChatData,
          //   tooltip: '重新載入',
          // ),
          // 清除聊天記錄按鈕
          // IconButton(
          //   icon: const Icon(Icons.delete_sweep),
          //   onPressed: _showClearChatDialog,
          //   tooltip: '清除聊天記錄',
          // ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // 聊天訊息列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];

                if (message.isMyMessage) {
                  return Column(
                    children: [
                      if (index > 0) const SizedBox(height: 16),
                      _buildMyMessage(message: message.message),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      if (index > 0) const SizedBox(height: 16),
                      _buildOtherMessage(
                        name: message.senderName ?? "Unknown",
                        avatarPath: message.avatarPath ?? "assets/profile.png",
                        message: message.message,
                        hasImage: message.hasImage,
                        imagePath: message.imagePath,
                      ),
                    ],
                  );
                }
              },
            ),
          ),

          // 訊息統計顯示
          if (_chatMessages.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                // '共 ${_chatMessages.length} 條訊息 (內存存儲)',
                '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),

          // 輸入區
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF556B2F),
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
                      color: const Color(0xFFF5F5DC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      style: const TextStyle(color: Colors.black),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) {
                        print("onSubmitted 被觸發: '$value'");
                        _sendMessage();
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFFDF6EC),
    );
  }

  // 顯示清除聊天記錄的對話框
  void _showClearChatDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('清除聊天記錄'),
          content: const Text('確定要清除所有聊天記錄嗎？此操作無法復原。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _clearChatMessages();
              },
              child: const Text('確定'),
            ),
          ],
        );
      },
    );
  }

  // 清除聊天記錄
  Future<void> _clearChatMessages() async {
    try {
      // 清除內存中的資料
      _memoryStorage.remove(widget.groupName);

      // 重新載入初始訊息
      setState(() {
        _chatMessages = _getInitialMessages();
      });

      // 保存新的初始狀態
      await _saveChatData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('聊天記錄已清除')),
      );
    } catch (e) {
      print('清除聊天記錄時發生錯誤: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('清除失敗')),
      );
    }
  }

  // 獲取初始訊息
  List<ChatMessage> _getInitialMessages() {
    switch (widget.groupName) {
      case 'Jordan一家親(32)':
        return _getJordanFamilyMessages();
      case '台北大咖們(103)':
        return _getTaipeiMessages();
      case '全桃聯對料(5)':
        return _getTaoyuanMessages();
      default:
        return _getDefaultMessages();
    }
  }

  // Jordan一家親的初始訊息
  List<ChatMessage> _getJordanFamilyMessages() {
    return [
      ChatMessage(
        message: "這是我做的梗圖，快來看覓～",
        isMyMessage: false,
        senderName: "Jordan01",
        avatarPath: "assets/profile1.png",
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ChatMessage(
        message: "",
        isMyMessage: false,
        senderName: "Jordan本體",
        avatarPath: "assets/profile2.png",
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        hasImage: true,
        imagePath: "assets/meme1.png",
      ),
      ChatMessage(
        message: "好讚喔😂😂😂😂😂",
        isMyMessage: false,
        senderName: "Jordan01",
        avatarPath: "assets/profile2.png",
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      ChatMessage(
        message: "天壽讚喔，繼續努力",
        isMyMessage: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];
  }

  // 台北大咖們的初始訊息
  List<ChatMessage> _getTaipeiMessages() {
    return [
      ChatMessage(
        message: "今天天氣真好耶！",
        isMyMessage: false,
        senderName: "台北小王",
        avatarPath: "assets/profile1.png",
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      ChatMessage(
        message: "要不要一起去信義區逛街？",
        isMyMessage: false,
        senderName: "大咖阿明",
        avatarPath: "assets/profile3.png",
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ChatMessage(
        message: "好啊！幾點集合？",
        isMyMessage: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ];
  }

  // 全桃聯對料的初始訊息
  List<ChatMessage> _getTaoyuanMessages() {
    return [
      ChatMessage(
        message: "大家好，歡迎加入全桃聯對料群組！",
        isMyMessage: false,
        senderName: "桃園老大",
        avatarPath: "assets/profile1.png",
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      ChatMessage(
        message: "謝謝老大！請多指教",
        isMyMessage: false,
        senderName: "桃園小弟",
        avatarPath: "assets/profile3.png",
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      ChatMessage(
        message: "大家好！",
        isMyMessage: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }

  // 預設初始訊息
  List<ChatMessage> _getDefaultMessages() {
    return [
      ChatMessage(
        message: "歡迎來到 ${widget.groupName} 群組！",
        isMyMessage: false,
        senderName: "系統訊息",
        avatarPath: "assets/profile3.png",
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
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
                            const Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 40,
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
  // 自己的訊息（右側顯示，無頭像）
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
        // 移除了頭像和 SizedBox
      ],
    );
  }
}
