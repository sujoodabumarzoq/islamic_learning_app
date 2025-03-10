import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int time;
  final int attempts;

  const ResultScreen({Key? key, required this.time, required this.attempts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("نتيجة اللعبة"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("الوقت المستغرق: $time ثانية"),
            Text("عدد المحاولات: $attempts"),
            const SizedBox(height: 20),
            const Text("التقييم: ⭐⭐⭐"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // العودة إلى شاشة اللعب
              },
              child: const Text("العب مرة أخرى"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst); // العودة إلى القائمة الرئيسية
              },
              child: const Text("العودة إلى القائمة الرئيسية"),
            ),
          ],
        ),
      ),
    );
  }
}