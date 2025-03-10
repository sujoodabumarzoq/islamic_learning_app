import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:islamic_learning_app/screen/Features/story/story.dart';

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

// class Story {
//   final String title;
//   final String difficulty;
//   final bool isCompleted;
//   final String content;
//   final String audio; // إضافة خاصية audio
//   final String animation; // إضافة خاصية animation
//   final List<Map<String, String>> interactiveButtons; // إضافة خاصية interactiveButtons
//
//   Story({
//     required this.title,
//     required this.difficulty,
//     required this.isCompleted,
//     required this.content,
//     required this.audio,
//     required this.animation,
//     required this.interactiveButtons,
//   });
//
//   factory Story.fromJson(Map<String, dynamic> json) {
//     return Story(
//       title: json['title'],
//       difficulty: json['difficulty'],
//       isCompleted: json['isCompleted'],
//       content: json['content'],
//       audio: json['audio'],
//       animation: json['animation'],
//       interactiveButtons: List<Map<String, String>>.from(json['interactiveButtons']),
//     );
//   }
// }
// class StoryCard extends StatelessWidget {
//   final Story story;
//
//   const StoryCard({Key? key, required this.story}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   Icons.book, // أيقونة تمثل القصة
//                   size: 40,
//                   color: Colors.blue,
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Text(
//                     story.title,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.star, color: Colors.amber, size: 16),
//                 const SizedBox(width: 4),
//                 Text(
//                   "صعوبة: ${story.difficulty}",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//             if (story.isCompleted)
//               Container(
//                 margin: const EdgeInsets.only(top: 8),
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.green[50],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Text(
//                   "مكتملة",
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }