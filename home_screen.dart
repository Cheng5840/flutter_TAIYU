import 'package:flutter/material.dart';
import 'group_page.dart'; // 引入新的群組頁面
import 'profile_page.dart'; // 引入新的個人資料頁面

void main() {
  runApp(const MemeApp());
}

/// 根應用程式
class MemeApp extends StatelessWidget {
  const MemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '台語迷因互動平台',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white, // 米色背景
        primaryColor: const Color(0xFF8B4C2F), // 棕色主色
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          titleMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFFF0D8AF),
          labelStyle: const TextStyle(color: Colors.brown),
          selectedColor: const Color(0xFF8B4C2F),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFF4D6),
          hintStyle: const TextStyle(color: Colors.brown),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

/// 首頁
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // 定義底部導航頁面
  final List<Widget> _pages = [
    const MainContentPage(), // 主畫面內容
    const Center(child: Text('編輯器頁面')), // 暫時用 placeholder
    const GroupPage(), // 群組頁面
    const ProfilePage(), // 個人資料頁面
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // 根據索引顯示頁面
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF484E32),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFFFFE6C9),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        iconSize: 32, // 放大圖示 (預設值是24)
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10), // 向下挪一點點
              child: Icon(Icons.home),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10), // 向下挪一點點
              child: Icon(Icons.edit),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10), // 向下挪一點點
              child: Icon(Icons.group),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10), // 向下挪一點點
              child: Icon(Icons.person),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

/// 主畫面內容（原本的 HomePage 內容）
class MainContentPage extends StatelessWidget {
  const MainContentPage({super.key});

  // 模擬限時動態資料
  final List<Map<String, String>> storiesData = const [
    {
      'author_image': 'assets/profile2.png',
      'image':        'assets/meme2.png',
      'author':       '邱哥',
      'timeAgo':      '28min',
      'caption':      '好好笑喔 怎麼那麼白癡\n(*°▽°*)',
    },
    {
      'author_image': 'assets/profile3.png',
      'image':        'assets/meme3.png',
      'author':       '阿明',
      'timeAgo':      '1h',
      'caption':      '這段超有梗！😂',
    },
    {
      'author_image': 'assets/profile4.png',
      'image':        'assets/meme4.png',
      'author':       '小美',
      'timeAgo':      '2h',
      'caption':      '快來看我新拍的影片～',
    },
    {
      'author_image': 'assets/profile5.png',
      'image':        'assets/profile_group.png',
      'author':       '阿伯',
      'timeAgo':      '3h',
      'caption':      '天氣真好，一起出去走走吧。',
    },
    {
      'author_image': 'assets/profile5.png',
      'image':        'assets/profile_group.png',
      'author':       '阿伯',
      'timeAgo':      '3h',
      'caption':      '天氣真好，一起出去走走吧。',
    },
    {
      'author_image': 'assets/profile5.png',
      'image':        'assets/profile_group.png',
      'author':       '阿伯',
      'timeAgo':      '3h',
      'caption':      '天氣真好，一起出去走走吧。',
    },
    {
      'author_image': 'assets/profile5.png',
      'image':        'assets/profile_group.png',
      'author':       '阿伯',
      'timeAgo':      '3h',
      'caption':      '天氣真好，一起出去走走吧。',
    },
    {
      'author_image': 'assets/profile5.png',
      'image':        'assets/profile_group.png',
      'author':       '阿伯',
      'timeAgo':      '3h',
      'caption':      '天氣真好，一起出去走走吧。',
    },
  ];

  // 模擬推薦搜尋關鍵字
  final List<String> keywords = const [
    '母通',
    '規細膩了',
    '激予搖搖',
    '膨風',
    '哈哈',
    '落跑'
  ];

  // 生成迷因資料（使用第一個版本的結構）
  List<Meme> _generateMemes() {
    final memeData = [
      {
        'image': 'assets/meme1.png',
        'likes': 100,
        'title': '',
        'author': '邱哥',
        'caption': '哈哈這是我設計的啦～\n如果喜歡的話可以下載、分享喔！'
      },
      {
        'image': 'assets/meme2.png',
        'likes': 105,
        'title': '無咧無盡',
        'author': '阿明',
        'caption': '這個梗超經典的！\n每次看都笑到肚子痛 😂'
      },
      {
        'image': 'assets/meme3.png',
        'likes': 95,
        'title': '足想欲起眠床　結婚',
        'author': '小美',
        'caption': '台語真的很有趣耶～\n大家一起學台語吧！'
      },
      {
        'image': 'assets/meme4.png',
        'likes': 88,
        'title': '無咧無盡',
        'author': '阿伯',
        'caption': '這句話我阿嬤常常講！\n滿滿的回憶啊～'
      },
      {
        'image': 'assets/meme1.png',
        'likes': 110,
        'title': '足想欲起眠床　結婚',
        'author': '台語王',
        'caption': '正宗台語發音教學！\n歡迎大家多多練習 💪'
      },
      {
        'image': 'assets/meme2.png',
        'likes': 115,
        'title': '無咧無盡',
        'author': '迷因達人',
        'caption': '又一個爆紅迷因誕生！\n快來跟風製作吧～'
      },
      {
        'image': 'assets/meme3.png',
        'likes': 120,
        'title': '足想欲起眠床　結婚',
        'author': '創意小子',
        'caption': '靈感來自日常生活～\n台語迷因就是這麼有趣！'
      },
      {
        'image': 'assets/meme4.png',
        'likes': 125,
        'title': '無咧無盡',
        'author': '搞笑阿姨',
        'caption': '笑死我了！這個太貼切～\n分享給朋友們看看 😆'
      },
      {
        'image': 'assets/meme1.png',
        'likes': 130,
        'title': '足想欲起眠床　結婚',
        'author': '文化推手',
        'caption': '用迷因傳承台語文化！\n讓年輕人也愛上台語 ❤️'
      },
      {
        'image': 'assets/meme2.png',
        'likes': 135,
        'title': '無咧無盡',
        'author': '幽默大師',
        'caption': '這個創意100分！\n台語迷因新高度達成 🎉'
      },
      {
        'image': 'assets/meme3.png',
        'likes': 140,
        'title': '足想欲起眠床　結婚',
        'author': '設計師小王',
        'caption': '花了三小時做的作品！\n希望大家會喜歡～'
      },
      {
        'image': 'assets/meme4.png',
        'likes': 145,
        'title': '無咧無盡',
        'author': '網紅小花',
        'caption': '我的第一個台語迷因作品！\n請大家多多指教 🥰'
      },
    ];

    return memeData.map((data) {
      return Meme(
        image: data['image'] as String,
        likes: data['likes'] as int,
        title: data['title'] as String,
        author: data['author'] as String,
        caption: data['caption'] as String,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final memes = _generateMemes(); // 在 build 中動態生成 memes
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // 1. 搜尋欄
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: '搜尋台語迷因',
                hintStyle: const TextStyle(fontSize: 14), // 這裡直接調整字體大小
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // 調窄高度
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color(0xFFAEB996),
                filled: true,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 2. 推薦關鍵字
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: keywords.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, idx) {
                return ActionChip(
                  label: Text(
                    keywords[idx],
                    style: const TextStyle(
                      fontSize: 12,           // 調整字體大小
                      color: Colors.black, // 這裡設定文字顏色
                    ),
                  ),
                  backgroundColor: Colors.white,
                  visualDensity: VisualDensity.compact, // 壓縮高度
                  onPressed: () {
                    // TODO: 觸發搜尋
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // 3. 限時動態區
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: storiesData.length,
              itemBuilder: (context, idx) {
                final story = storiesData[idx];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StoryPage(
                          author_image: story['author_image']!,
                          image:        story['image']!,
                          author:       story['author']!,
                          timeAgo:      story['timeAgo']!,
                          caption:      story['caption']!,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFDAD2C6),
                    backgroundImage: AssetImage(story['author_image']!),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: idx == 1 ? Colors.red : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              // itemCount: story.length,
            ),
          ),

          const SizedBox(height: 16),

          // 4. 本月排行榜
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '本月台語迷因排行榜',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: memes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, idx) {
                final m = memes[idx];
                return MemeCard(meme: m);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 單張迷因卡片（使用第一個版本的彈窗功能）
class MemeCard extends StatelessWidget {
  final Meme meme;
  const MemeCard({super.key, required this.meme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => MemeDetailDialog(meme: meme),
        );
      },
      child: Card(
        color: const Color(0xFFEFEFEF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          // side: const BorderSide(color: Color(0xFF8B4C2F), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  meme.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('無法載入圖片'));
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: Text(
            //     meme.title,
            //     style: const TextStyle(fontSize: 0),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.favorite_border, size: 18, color: Colors.red),
                  const SizedBox(width: 4),
                  Text('${meme.likes}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 彈窗顯示迷因詳情（修改為新樣式）
class MemeDetailDialog extends StatelessWidget {
  final Meme meme;
  const MemeDetailDialog({super.key, required this.meme});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // 設定彈窗的尺寸（佔螢幕的百分比）
    final dialogHeight = screenHeight * 0.8; // 高度為螢幕的80%
    final dialogWidth = screenWidth * 0.9;   // 寬度為螢幕的90%

    // 根據螢幕寬度調整圖片高度
    final imageHeight = screenWidth < 400 ? 150.0 : 200.0;

    return Dialog(
      insetPadding: const EdgeInsets.all(16), // 控制 Dialog 與螢幕邊緣的距離
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 迷因圖片（不滿版）
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  meme.image,
                  height: 360,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: const Center(child: Text('無法載入圖片')),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 作者資訊行
            Row(
              children: [
                // 作者頭像
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),

                const SizedBox(width: 12),

                // 作者名稱和追蹤按鈕（垂直排列）
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meme.author,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // 文字描述
            Text(
              meme.caption,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 4),

            // 底部按鈕區
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 分享按鈕
                IconButton(
                  onPressed: () {
                    // TODO: 實現分享功能
                  },
                  icon: const Icon(Icons.send, size: 24),
                  color: Colors.grey[600],
                ),

                const SizedBox(width: 2),

                // 點讚按鈕
                IconButton(
                  onPressed: () {
                    // TODO: 實現點讚功能
                  },
                  icon: const Icon(Icons.thumb_up, size: 24),
                  color: Colors.grey[600],
                ),

                const SizedBox(width: 0),

                // 下載按鈕
                IconButton(
                  onPressed: () {
                    // TODO: 實現下載功能
                  },
                  icon: const Icon(Icons.download, size: 26),
                  color: Colors.grey[600],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 迷因模型（整合兩個版本的屬性）
class Meme {
  final String image;
  final String title;
  final int likes;
  final String author;
  final String caption;

  Meme({
    required this.image,
    required this.title,
    required this.likes,
    required this.author,
    required this.caption,
  });
}

/// 點擊限時動態後顯示的畫面
class StoryPage extends StatelessWidget {
  final String author_image;
  final String image;
  final String author;
  final String timeAgo;
  final String caption;

  const StoryPage({
    super.key,
    required this.author_image,
    required this.image,
    required this.author,
    required this.timeAgo,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Column(
          children: [
            // 頂部作者資訊區（與螢幕頂部有間距）
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 16, 8),
              child: Row(
                children: [
                  // 作者頭像
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(author_image),//AssetImage('assets/profile.png'),
                  ),
                  const SizedBox(width: 12),

                  // 作者名稱和時間
                  Text(
                    '$author  $timeAgo',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Spacer(),

                  // 關閉按鈕
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // 中間圖片區域（不滿版，可調整大小）
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain, // 改為 contain 讓圖片完整顯示
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              '無法載入圖片',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // 底部描述文字
            // 底部描述文字
            if (caption.isNotEmpty)
              Transform.translate(
                offset: const Offset(5, -100),   // 向上移 30px
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 16, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      caption,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),


            // 底部輸入框和愛心按鈕
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  // 長條形輸入框
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.transparent, // 透明背景
                        border: Border.all(color: Colors.grey.shade500, width: 1),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none, // 不要內建邊框
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          filled: false, // 讓 TextField 不要自帶底色
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // 愛心按鈕
                  GestureDetector(
                    onTap: () {
                      // TODO: 實現點讚功能
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}