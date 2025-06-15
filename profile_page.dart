import 'package:flutter/material.dart';

/// 定義通知類型枚舉
enum NotificationType {
  friendRequest,
  like,
  other,
}

/// 輔助類別來儲存詞彙資料
class _WordData {
  final String word;
  final String partOfSpeech;
  final String pinyin;
  final String taiwanese;

  _WordData({
    required this.word,
    required this.partOfSpeech,
    required this.pinyin,
    required this.taiwanese,
  });
}


/// 個人資料頁面
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});


  void _showSearchHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // 螢幕寬度 80%
            height: MediaQuery.of(context).size.height * 0.7, // 螢幕高度 70%
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFFDF6EC), // 米色背景
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      height: 28,
                      width: 230,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: '',
                          hintStyle: const TextStyle(fontSize: 14),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color(0xFFAEB996),
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchItem('5/8', [
                          _WordData(
                              word: '結婚',
                              partOfSpeech: 'v.',
                              pinyin: 'sèng-tshìn',
                              taiwanese: '成親'),
                          _WordData(
                              word: '床',
                              partOfSpeech: 'n.',
                              pinyin: 'bîn-tshng',
                              taiwanese: '眠床'),
                        ]),
                        _buildSearchItem('5/7', [
                          _WordData(
                              word: '裝逼',
                              partOfSpeech: 'v.',
                              pinyin: 'kè-siuⁿ',
                              taiwanese: '假仙'),
                        ]),
                        _buildSearchItem('5/1', [
                          _WordData(
                              word: '靜靜',
                              partOfSpeech: 'a.',
                              pinyin: 'tiām-tiām',
                              taiwanese: '恬靜'),
                        ]),
                        _buildSearchItem('4/26', [
                          _WordData(
                              word: 'RUBY醬',
                              partOfSpeech: 'n.',
                              pinyin: 'sī-tō',
                              taiwanese: 'RUBY先生小姐'),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchItem(String date, List<_WordData> words) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          ...words.map((wordData) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              children: [
                // 左邊：中文詞
                SizedBox(
                  width: 80, // 固定寬度給中文詞
                  child: Text(
                    wordData.word,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 12),
                // 詞性圓圈
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black54, // 圓圈顏色
                  ),
                  child: Center(
                    child: Text(
                      wordData.partOfSpeech,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // 右邊：拼音和台語翻譯，採用兩列式排版
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 第一行：拼音（小字，灰色）
                      Text(
                        wordData.pinyin,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // 第二行：台語翻譯（正常大小）
                      Text(
                        wordData.taiwanese,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
  void _showFriendListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFFDF6EC),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 標題
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '好友 5',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 好友列表
                _buildFriendItem('Leo', 'Online', 'assets/profile1.png'),
                _buildFriendItem('Ethan', 'Offline', 'assets/profile2.png'),
                _buildFriendItem('Olivia', 'Offline', 'assets/profile3.png'),
                _buildFriendItem('Liam', 'Offline', 'assets/profile4.png'),
                _buildFriendItem('Brain', 'Offline', 'assets/profile5.png'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFriendItem(String name, String status, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 14,
                  color: status == 'Online' ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 顯示通知彈窗
  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: const Color(0xFFFDF6EC),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,  // 螢幕寬度的 80%
            height: MediaQuery.of(context).size.height * 0.6, // 螢幕高度的 70%
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    '今仔日',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // ],

                  const SizedBox(height: 8),
                  // 通知項目
                  _buildNotificationItem(
                    avatar: const CircleAvatar(
                      radius: 20,                                      // 可以保留或調整
                      backgroundImage: const AssetImage(
                        'assets/profile.png',                 // 換成你的頭像檔案
                      ),
                      backgroundColor: Colors.transparent,            // 若圖片有透明背景可留空
                    ),
                    title: 'Jordan01 向你發送好友邀請',
                    time: '10 分鐘前',
                    notificationType: NotificationType.friendRequest,
                  ),
                  _buildNotificationItem(
                    avatar: const CircleAvatar(
                      radius: 20,                                      // 可以保留或調整
                      backgroundImage: const AssetImage(
                        'assets/profile1.png',                 // 換成你的頭像檔案
                      ),
                      backgroundColor: Colors.transparent,            // 若圖片有透明背景可留空
                    ),
                    title: '我是老奈 點讚了你的貼文',
                    time: '15 分鐘前',
                    notificationType: NotificationType.like,
                  ),
                  _buildNotificationItem(
                    avatar: const CircleAvatar(
                      radius: 20,                                      // 可以保留或調整
                      backgroundImage: const AssetImage(
                        'assets/profile2.png',                 // 換成你的頭像檔案
                      ),
                      backgroundColor: Colors.transparent,            // 若圖片有透明背景可留空
                    ),
                    title: 'tai-gi很難 向你發送好友邀請',
                    time: '6 小時前',
                    notificationType: NotificationType.friendRequest,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '往週',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildNotificationItem(
                    avatar: const CircleAvatar(
                      radius: 20,                                      // 可以保留或調整
                      backgroundImage: const AssetImage(
                        'assets/profile3.png',                 // 換成你的頭像檔案
                      ),
                      backgroundColor: Colors.transparent,            // 若圖片有透明背景可留空
                    ),
                    title: 'yoooooo 點讚了你的貼文',
                    time: '1 天前',
                    notificationType: NotificationType.like,
                  ),
                  _buildNotificationItem(
                    avatar: const CircleAvatar(
                      radius: 20,                                      // 可以保留或調整
                      backgroundImage: const AssetImage(
                        'assets/profile5.png',                 // 換成你的頭像檔案
                      ),
                      backgroundColor: Colors.transparent,            // 若圖片有透明背景可留空
                    ),
                    title: '邀請你加入 做大點tai-gi',
                    time: '1 天前',
                    notificationType: NotificationType.friendRequest,
                  ),
                ],
              ),
            )
            // color: const Color(0xFFFDF6EC), // 米色背景
          ),
        ),

    );
  }

  // 定義通知類型枚舉已移到頂層

  // 構建單個通知項目
  Widget _buildNotificationItem({
    required Widget avatar,
    required String title,
    required String time,
    required NotificationType notificationType,
  }) {
    if (notificationType == NotificationType.friendRequest) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 100), // 預留空間給右下角按鈕
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  avatar,
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          time,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              right: 0,
              child: Row(
                children: [
                  _buildTextButton(
                    // pronunciation: "san tû",
                    pronunciation: "",
                    text: "好 ho",
                    onPressed: () {
                      // TODO: 處理刪除
                    },
                  ),
                  const SizedBox(width: 4),
                  _buildTextButton(
                    // pronunciation: "khak jīn",
                    pronunciation: "",
                    text: "莫 mai",
                    onPressed: () {
                      // TODO: 處理確認
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // 其他通知類型維持原樣
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          avatar,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          if (notificationType == NotificationType.like)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
                image: const DecorationImage(
                  image: AssetImage('assets/meme2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else if (notificationType == NotificationType.other)
            IconButton(
              icon: const Icon(Icons.arrow_forward, size: 20),
              onPressed: () {
                // TODO: 處理查看詳情
              },
            ),
        ],
      ),
    );
  }

  // 創建文字形式的按鈕
  Widget _buildTextButton({
    required String text,
    required String pronunciation,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 28, // 縮小高度
      width: 50,
      // constraints: const BoxConstraints(minWidth: 56), // 縮小最小寬度
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFAEB996), // 橙色/琥珀色背景
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0), // 縮小內邊距
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 10, // 縮小字體
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(height: 4), // 控制上下間距，預設約為 4-6，可調小
            Text(
              pronunciation,
              style: const TextStyle(
                fontSize: 8, // 縮小發音字體
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications), // 通知鈴鐺圖標
            onPressed: () {
              _showNotificationDialog(context); // 點擊時顯示通知彈窗
            },
          ),
          // const IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: null, // 暫時禁用，根據需求實現
          // ),
        ],
        backgroundColor: const Color(0xFFFDF6EC), // 米色背景
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.png'),//AssetImage('assets/profile.png'),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Jordan',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 150, // 調整按鈕的左右寬度
            child: ElevatedButton(
                onPressed: () {
                  // TODO: 處理編輯個人資料
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF484E32),
                  // foregroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  '🏆 本周冠軍  ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ), // 設定你要的字體大小

                )
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 38),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFAEB996),
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: Colors.blue), // 可依需求調整
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('222', '追蹤'),
                _buildStatColumn('666', '按讚'),
                _buildStatColumn('77', '分享'),
              ],
            ),
          ),

          const SizedBox(height: 16),


          Container(
            margin: const EdgeInsets.symmetric(horizontal: 38),
            decoration: BoxDecoration(
              color: const Color(0xFFAEB996),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView(
              shrinkWrap: true,  // ✅ 高度依內容自適應
              physics: const NeverScrollableScrollPhysics(),  // ✅ 不要自己捲動（由外層 ListView 捲動）
              padding: const EdgeInsets.all(16),
              children: [
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text('搜尋紀錄'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    _showSearchHistoryDialog(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('好友列表'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    _showFriendListDialog(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('設定'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          )

          // Expanded(
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(horizontal: 38), // 調整外邊距
          //     decoration: BoxDecoration(
          //       color: const Color(0xFFF0D8AF), // 與上方卡片相同背景色
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: ListView(
          //       padding: const EdgeInsets.all(16), // 內部填充
          //       children: const [
          //         ListTile(
          //           leading: Icon(Icons.search),
          //           title: Text('搜尋歷史紀錄'),
          //           trailing: Icon(Icons.chevron_right),
          //         ),
          //         ListTile(
          //           leading: Icon(Icons.favorite),
          //           title: Text('我的收藏清單'),
          //           trailing: Icon(Icons.chevron_right),
          //         ),
          //         ListTile(
          //           leading: Icon(Icons.settings),
          //           title: Text('基本設定與權限'),
          //           trailing: Icon(Icons.chevron_right),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      backgroundColor: const Color(0xFFFDF6EC), // 米色背景
    );
  }
}

/// 建立統計欄
Widget _buildStatColumn(String number, String chinese) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        number,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        chinese,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    ],
  );
}
