import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:islamic_learning_app/Model/story.dart';

import 'StoryCard.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  // Future<List<Story>> loadStories() async {
  //   // تحميل ملف JSON من المجلد assets
  //   final String response = await rootBundle.loadString('assets/stories.json');
  //   // تحويل JSON إلى قائمة من الكائنات
  //   final List<dynamic> data = json.decode(response);
  //   // تحويل البيانات إلى قائمة من Story
  //   return data.map((story) => Story.fromJson(story)).toList();
  // }
  Future<List<Story>> loadStories() async {
    // تحميل ملف JSON من المجلد assets
    final String response = await rootBundle.loadString('assets/stories.json');
    // تحويل JSON إلى قائمة من الكائنات
    final List<dynamic> data = json.decode(response);
    // تحويل البيانات إلى قائمة من Story
    return data.map((story) => Story.fromJson(story)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("قصص الأنبياء"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // تطبيق التصفية حسب القيمة المحددة
              print("تم التصفية حسب: $value");
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "الأقدم",
                  child: Text("الأقدم"),
                ),
                const PopupMenuItem(
                  value: "الأحدث",
                  child: Text("الأحدث"),
                ),
                const PopupMenuItem(
                  value: "الأكثر قراءة",
                  child: Text("الأكثر قراءة"),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Story>>(
        future: loadStories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد بيانات'));
          } else {
            final stories = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                return StoryCard(story: story);
              },
            );
          }
        },
      ),    );
  }
}

