import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // متغيرات حالة الإعدادات
  bool isSoundEnabled = true;
  double volumeLevel = 0.7;
  String selectedBackground = 'default';
  String fontSize = 'medium';
  bool areNotificationsEnabled = true;

  // خيارات الخلفيات المتاحة
  final List<Map<String, dynamic>> backgroundOptions = [
    {'id': 'default', 'name': 'الخلفية الافتراضية', 'color': Colors.white},
    {'id': 'light_blue', 'name': 'أزرق فاتح', 'color': Colors.lightBlue[50]},
    {'id': 'light_green', 'name': 'أخضر فاتح', 'color': Colors.lightGreen[50]},
    {'id': 'beige', 'name': 'بيج', 'color': const Color(0xFFF5F5DC)},
  ];

  // خيارات أحجام الخط
  final Map<String, double> fontSizeOptions = {
    'small': 14.0,
    'medium': 16.0,
    'large': 18.0,
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // تحميل الإعدادات المحفوظة
  _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSoundEnabled = prefs.getBool('isSoundEnabled') ?? true;
      volumeLevel = prefs.getDouble('volumeLevel') ?? 0.7;
      selectedBackground = prefs.getString('selectedBackground') ?? 'default';
      fontSize = prefs.getString('fontSize') ?? 'medium';
      areNotificationsEnabled = prefs.getBool('areNotificationsEnabled') ?? true;
    });
  }

  // حفظ الإعدادات
  _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSoundEnabled', isSoundEnabled);
    await prefs.setDouble('volumeLevel', volumeLevel);
    await prefs.setString('selectedBackground', selectedBackground);
    await prefs.setString('fontSize', fontSize);
    await prefs.setBool('areNotificationsEnabled', areNotificationsEnabled);
  }

  // فتح رابط التقييم
  void _launchRatingURL() async {
    const url = 'https://play.google.com/store/apps/details?id=com.yourcompany.islamic_learning_app';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يمكن فتح رابط المتجر')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // قسم التحكم في الصوت
            _buildSectionTitle('التحكم في الصوت'),
            SwitchListTile(
              title: const Text('تشغيل الصوت'),
              value: isSoundEnabled,
              onChanged: (value) {
                setState(() {
                  isSoundEnabled = value;
                  _saveSettings();
                });
              },
              secondary: const Icon(Icons.volume_up),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.volume_down, size: 20),
                  Expanded(
                    child: Slider(
                      value: volumeLevel,
                      onChanged: isSoundEnabled
                          ? (value) {
                        setState(() {
                          volumeLevel = value;
                          _saveSettings();
                        });
                      }
                          : null,
                    ),
                  ),
                  const Icon(Icons.volume_up, size: 20),
                ],
              ),
            ),

            const Divider(),

            // قسم اختيار الخلفية
            _buildSectionTitle('خلفية التطبيق'),
            _buildBackgroundSelector(),

            const Divider(),

            // قسم حجم الخط
            _buildSectionTitle('حجم الخط'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFontSizeButton('small', 'صغير'),
                  _buildFontSizeButton('medium', 'متوسط'),
                  _buildFontSizeButton('large', 'كبير'),
                ],
              ),
            ),

            const Divider(),

            // قسم إعدادات الإشعارات
            _buildSectionTitle('الإشعارات'),
            SwitchListTile(
              title: const Text('تفعيل الإشعارات'),
              value: areNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  areNotificationsEnabled = value;
                  _saveSettings();
                });
              },
              secondary: const Icon(Icons.notifications),
            ),

            const Divider(),

            // قسم معلومات التطبيق والتواصل
            _buildSectionTitle('حول التطبيق'),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('عن التطبيق'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('عن التطبيق'),
                    content: const Text(
                      'تطبيق التعلم الإسلامي\nالإصدار: 1.0.0\n\nتطبيق تعليمي للمسلمين يساعد على تعلم القرآن الكريم وأسماء الله الحسنى والسيرة النبوية والمزيد من المعلومات الإسلامية.',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('إغلاق'),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text('تواصل مع المطورين'),
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'support@example.com',
                  queryParameters: {'subject': 'استفسار حول تطبيق التعلم الإسلامي'},
                );

                if (await canLaunch(emailLaunchUri.toString())) {
                  await launch(emailLaunchUri.toString());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('لا يمكن فتح تطبيق البريد الإلكتروني')),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('تقييم التطبيق'),
              onTap: _launchRatingURL,
            ),
          ],
        ),
      ),
    );
  }

  // بناء عنوان القسم
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, right: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // بناء محدد الخلفية
  Widget _buildBackgroundSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 12.0,
        runSpacing: 12.0,
        children: backgroundOptions.map((option) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedBackground = option['id'];
                _saveSettings();
              });
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: option['color'],
                border: Border.all(
                  color: selectedBackground == option['id']
                      ? Colors.blue
                      : Colors.grey,
                  width: selectedBackground == option['id'] ? 3 : 1,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  option['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: selectedBackground == option['id']
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // بناء زر اختيار حجم الخط
  Widget _buildFontSizeButton(String size, String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          fontSize = size;
          _saveSettings();
        });
      },
      style: ElevatedButton.styleFrom(
        primary: fontSize == size ? Colors.blue : Colors.grey[300],
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSizeOptions[size],
          color: fontSize == size ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}



