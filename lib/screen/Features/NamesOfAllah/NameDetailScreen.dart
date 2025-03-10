//SvgPicture

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NameDetailScreen extends StatelessWidget {
  final String name;

  const NameDetailScreen({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الاسم"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                name,
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // إضافة وظيفة الاستماع هنا
              },
              child: const Text("استمع إلى النطق"),
            ),
            const SizedBox(height: 20),
            const Text(
              "الرحمن: هو الله الذي وسعت رحمته كل شيء.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            SvgPicture.asset(
              "assets/images/Allah.svg", // استبدل بمسار الصورة
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              "مثال: عندما تحس بالراحة والأمان، فهذا من رحمة الله الرحمن.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // إضافة وظيفة النشاط هنا
              },
              child: const Text("النشاط التفاعلي"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // الانتقال إلى الاسم السابق
                  },
                  child: const Text("السابق"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // الانتقال إلى الاسم التالي
                  },
                  child: const Text("التالي"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}