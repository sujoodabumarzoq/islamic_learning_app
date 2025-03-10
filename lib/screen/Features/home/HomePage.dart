// ignore: file_names
import 'package:flutter/material.dart';
import 'package:islamic_learning_app/screen/Features/MemoryGameScreen/MemoryGameScreen.dart';
import 'package:islamic_learning_app/screen/Features/NamesOfAllah/NamesOfAllahScreen.dart';
import 'package:islamic_learning_app/screen/Features/SettingsScreen/SettingsScreen.dart';
import 'package:islamic_learning_app/screen/Features/UserProfileScreen/UserProfileScreen.dart';

import '../story/StoriesScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الشاشة الرئيسية"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  SettingsScreen()),
              );

              // الانتقال إلى الإعدادات
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // الانتقال إلى ملف المستخدم
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  UserProfileScreen()),
              );

            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // الانتقال إلى المفضلة
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // زر قصص الأنبياء
                GestureDetector(
                  onTap: () {
                    // الانتقال إلى واجهة قصص الأنبياء
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StoriesScreen()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.book, // أيقونة قصص الأنبياء
                        size: 80, // حجم الأيقونة
                        color: Colors.blue, // لون الأيقونة
                      ),
                      const SizedBox(height: 8), // مسافة بين الأيقونة والنص
                      const Text(
                        "قصص الأنبياء",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                // زر لعبة الذاكرة
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  MemoryGameScreen()),
                    );

                    // الانتقال إلى لعبة الذاكرة
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.memory, // أيقونة لعبة الذاكرة
                        size: 80, // حجم الأيقونة
                        color: Colors.green, // لون الأيقونة
                      ),
                      const SizedBox(height: 8), // مسافة بين الأيقونة والنص
                      const Text(
                        "لعبة الذاكرة",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                // زر أسماء الله الحسنى
                GestureDetector(

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  NamesOfAllahScreen()),
                      );

                      // الانتقال إلى لعبة الذاكرة

                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.flag, // أيقونة أسماء الله الحسنى
                        size: 80, // حجم الأيقونة
                        color: Colors.orange, // لون الأيقونة
                      ),
                      const SizedBox(height: 8), // مسافة بين الأيقونة والنص
                      const Text(
                        "أسماء الله الحسنى",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "تقدمك العام:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                  ),
                  const SizedBox(height: 10),
                  const Text("70% مكتمل", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
