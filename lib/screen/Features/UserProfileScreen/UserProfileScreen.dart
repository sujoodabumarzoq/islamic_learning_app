import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:islamic_learning_app/Model/UserProfile.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProfile _userProfile;

  @override
  void initState() {
    super.initState();
    // تهيئة البيانات الأولية
    _userProfile = UserProfile(age: 5, currentChild: 'محمد');
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _userProfile.image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ملف المستخدم'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _userProfile.image != null ? FileImage(_userProfile.image!) : null,
                child: _userProfile.image == null ? Icon(Icons.camera_alt, size: 40) : null,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'اسم المستخدم: ${_userProfile.currentChild}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('العمر:'),
            DropdownButton<int>(
              value: _userProfile.age,
              onChanged: (newValue) {
                setState(() {
                  _userProfile.age = newValue!;
                });
              },
              items: List.generate(12, (index) => index + 3)
                  .map((age) => DropdownMenuItem(
                value: age,
                child: Text('$age سنوات'),
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text('مستوى التقدم العام:'),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Text('70% مكتمل'),
            SizedBox(height: 20),
            Text('الإنجازات والشارات:'),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Icon(Icons.emoji_events, size: 50, color: Colors.amber),
                    Text('إنجاز ${index + 1}'),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            Text('المحتوى المفضل:'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.star, color: Colors.yellow),
                  title: Text('عنوان المحتوى ${index + 1}'),
                );
              },
            ),
            SizedBox(height: 20),
            Text('إحصائيات الاستخدام:'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('الوقت الإجمالي:'),
                        Text('2 ساعة'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('عدد الجلسات:'),
                        Text('10 جلسات'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('تبديل الحساب:'),
            DropdownButton<String>(
              value: _userProfile.currentChild,
              onChanged: (newValue) {
                setState(() {
                  _userProfile.currentChild = newValue!;
                });
              },
              items: ['محمد', 'فاطمة', 'علي']
                  .map((child) => DropdownMenuItem(
                value: child,
                child: Text(child),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
