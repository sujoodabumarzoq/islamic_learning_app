import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with SingleTickerProviderStateMixin {
  // بيانات المستخدم
  String username = "أحمد";
  int age = 8;
  String avatarPath = "";
  double overallProgress = 0.65;

  // بيانات حسابات متعددة
  List<Map<String, dynamic>> childAccounts = [
    {"id": 1, "name": "أحمد", "age": 8, "avatar": ""},
    {"id": 2, "name": "سارة", "age": 6, "avatar": ""},
  ];
  int activeAccountId = 1;

  // بيانات الإنجازات
  List<Map<String, dynamic>> achievements = [
    {"id": 1, "title": "حفظ 5 سور", "icon": Icons.star, "completed": true},
    {"id": 2, "title": "إتمام دروس الوضوء", "icon": Icons.wash, "completed": true},
    {"id": 3, "title": "حفظ 10 أحاديث", "icon": Icons.book, "completed": false},
    {"id": 4, "title": "تعلم 20 اسم من أسماء الله", "icon": Icons.panorama_fish_eye, "completed": true},
    {"id": 5, "title": "إكمال قصص الأنبياء", "icon": Icons.history_edu, "completed": false},
  ];

  // بيانات المحتوى المفضل
  List<Map<String, dynamic>> favorites = [
    {"id": 1, "title": "سورة الإخلاص", "type": "سورة", "lastAccessed": "اليوم"},
    {"id": 2, "title": "قصة سيدنا يوسف", "type": "قصة", "lastAccessed": "أمس"},
    {"id": 3, "title": "دعاء قبل النوم", "type": "دعاء", "lastAccessed": "منذ 3 أيام"},
  ];

  // بيانات إحصائيات الاستخدام
  Map<String, dynamic> usageStats = {
    "totalMinutes": 420,
    "daysStreak": 7,
    "completedLessons": 24,
    "quizScores": 85,
  };

  // متغيرات للتحكم في التبويب
  late TabController _tabController;
  final List<String> _tabs = ["الإنجازات", "المفضلة", "الإحصائيات"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _loadUserData();
  }

  _loadUserData() async {
    // في التطبيق الحقيقي، ستقوم بتحميل البيانات من مصدر البيانات
    // مثل قاعدة بيانات محلية أو خدمة سحابية
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        avatarPath = image.path;
      });
      // في التطبيق الحقيقي، ستقوم بحفظ مسار الصورة
    }
  }

  void _switchAccount(int accountId) {
    setState(() {
      activeAccountId = accountId;
      // في التطبيق الحقيقي، ستقوم بتحميل بيانات الحساب المختار

      // للتوضيح، نغير البيانات افتراضياً:
      Map<String, dynamic> selectedAccount = childAccounts.firstWhere(
            (account) => account["id"] == accountId,
        orElse: () => childAccounts[0],
      );

      username = selectedAccount["name"];
      age = selectedAccount["age"];
      avatarPath = selectedAccount["avatar"];

      // تحديث الإنجازات والمفضلة والإحصائيات للحساب المختار
      // (في التطبيق الحقيقي)
    });
  }

  void _editUsername() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تعديل اسم المستخدم"),
        content: TextField(
          decoration: const InputDecoration(hintText: "أدخل الاسم الجديد"),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          onChanged: (value) {
            username = value;
          },
          controller: TextEditingController(text: username),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // تم تحديث الاسم بالفعل في onChanged
              });
              Navigator.pop(context);
            },
            child: const Text("حفظ"),
          ),
        ],
      ),
    );
  }

  void _editAge() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تعديل العمر"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (age > 4) setState(() => age--);
              },
            ),
            Text(
              age.toString(),
              style: const TextStyle(fontSize: 24),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (age < 12) setState(() => age++);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              // في التطبيق الحقيقي، ستقوم بحفظ العمر الجديد
              Navigator.pop(context);
            },
            child: const Text("حفظ"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الملف الشخصي"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // إضافة حساب جديد
              // في التطبيق الحقيقي، ستنتقل إلى شاشة إنشاء حساب جديد
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            _buildProfileHeader(),
            _buildAccountSwitcher(),
            _buildProgressSection(),
            _buildTabBar(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // صورة المستخدم
          Stack(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: avatarPath.isNotEmpty ? FileImage(File(avatarPath)) : null,
                  child: avatarPath.isEmpty
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // معلومات المستخدم
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 16),
                      onPressed: _editUsername,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "العمر: $age سنوات",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 16),
                      onPressed: _editAge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSwitcher() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: childAccounts.length,
        itemBuilder: (context, index) {
          final account = childAccounts[index];
          final isActive = account["id"] == activeAccountId;

          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () => _switchAccount(account["id"]),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: isActive ? Theme.of(context).primaryColor : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: Text(
                          account["name"][0],
                          style: TextStyle(
                            color: isActive ? Theme.of(context).primaryColor : Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        account["name"],
                        style: TextStyle(
                          color: isActive ? Colors.white : Colors.black,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "مستوى التقدم",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 10.0,
                percent: overallProgress,
                center: Text(
                  "${(overallProgress * 100).toInt()}%",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.green.shade100,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressItem("القرآن", 0.75, Colors.blue),
                    const SizedBox(height: 8),
                    _buildProgressItem("الأحاديث", 0.45, Colors.purple),
                    const SizedBox(height: 8),
                    _buildProgressItem("العبادات", 0.60, Colors.orange),
                    const SizedBox(height: 8),
                    _buildProgressItem("القصص", 0.80, Colors.teal),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String title, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        LinearPercentIndicator(
          lineHeight: 8.0,
          percent: progress,
          progressColor: color,
          backgroundColor: Colors.grey[200],
          barRadius: const Radius.circular(4),
          trailing: Text("${(progress * 100).toInt()}%"),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildTabContent() {
    return SizedBox(
      height: 400, // ارتفاع ثابت للمحتوى
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildAchievementsTab(),
          _buildFavoritesTab(),
          _buildStatsTab(),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: achievements.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return Card(
          elevation: 2,
          color: achievement["completed"] ? Colors.green[50] : Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  achievement["icon"],
                  size: 36,
                  color: achievement["completed"] ? Colors.green : Colors.grey,
                ),
                const SizedBox(height: 8),
                Text(
                  achievement["title"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: achievement["completed"] ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement["completed"] ? "مكتمل" : "قيد التقدم",
                  style: TextStyle(
                    fontSize: 12,
                    color: achievement["completed"] ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoritesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final favorite = favorites[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: _getIconForType(favorite["type"]),
            title: Text(favorite["title"]),
            subtitle: Text(favorite["type"]),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("آخر استخدام:"),
                Text(favorite["lastAccessed"]),
              ],
            ),
            onTap: () {
              // الانتقال إلى المحتوى المفضل
            },
          ),
        );
      },
    );
  }

  Widget _getIconForType(String type) {
    IconData iconData;

    switch (type) {
      case "سورة":
        iconData = Icons.book;
        break;
      case "قصة":
        iconData = Icons.history_edu;
        break;
      case "دعاء":
        iconData = Icons.volunteer_activism;
        break;
      default:
        iconData = Icons.star;
    }

    return CircleAvatar(
      backgroundColor: Colors.blue[50],
      child: Icon(iconData, color: Colors.blue),
    );
  }

  Widget _buildStatsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "إحصائيات الاستخدام (للوالدين)",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            title: "إجمالي وقت التعلم",
            value: "${usageStats["totalMinutes"]} دقيقة",
            icon: Icons.timer,
            color: Colors.blue,
          ),
          _buildStatCard(
            title: "أيام متتالية",
            value: "${usageStats["daysStreak"]} أيام",
            icon: Icons.local_fire_department,
            color: Colors.orange,
          ),
          _buildStatCard(
            title: "الدروس المكتملة",
            value: "${usageStats["completedLessons"]} درس",
            icon: Icons.school,
            color: Colors.purple,
          ),
          _buildStatCard(
            title: "متوسط درجات الاختبارات",
            value: "${usageStats["quizScores"]}%",
            icon: Icons.quiz,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}