import 'package:flutter/material.dart';
import 'package:islamic_learning_app/screen/Features/MemoryGameScreen/ResultScreen.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({Key? key}) : super(key: key);

  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  List<String> cards = [
    'A', 'A', 'B', 'B', 'C', 'C', 'D', 'D', 'E', 'E', 'F', 'F'
  ]; // مثال لبطاقات اللعبة
  List<bool> cardFlips = List.filled(12, true); // حالة البطاقات (مقلوبة أم لا)
  List<bool> cardMatched = List.filled(12, false); // تتبع البطاقات المطابقة
  int attempts = 0;
  int hintsUsed = 0;
  int matchedPairs = 0; // عدد الأزواج المطابقة

  void flipCard(int index) {
    setState(() {
      cardFlips[index] = !cardFlips[index];
    });

    // التحقق من وجود بطاقتين مقلوبتين
    List<int> flippedIndices = [];
    for (int i = 0; i < cardFlips.length; i++) {
      if (!cardFlips[i] && !cardMatched[i]) {
        flippedIndices.add(i);
      }
    }

    if (flippedIndices.length == 2) {
      attempts++;
      if (cards[flippedIndices[0]] == cards[flippedIndices[1]]) {
        // إذا كانت البطاقات متطابقة
        cardMatched[flippedIndices[0]] = true;
        cardMatched[flippedIndices[1]] = true;
        matchedPairs++;

        // التحقق من انتهاء اللعبة
        if (matchedPairs == cards.length ~/ 2) {
          // الانتقال إلى شاشة النتيجة
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(time: 120, attempts: attempts),
            ),
          );
        }
      } else {
        // إذا لم تكن البطاقات متطابقة، اقلبها مرة أخرى بعد تأخير
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            cardFlips[flippedIndices[0]] = true;
            cardFlips[flippedIndices[1]] = true;
          });
        });
      }
    }
  }

  void useHint() {
    if (hintsUsed < 3) {
      setState(() {
        hintsUsed++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لعبة الذاكرة"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: const EdgeInsets.all(16.0),

          children: [
            // مؤقت وعداد المحاولات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("الوقت: 00:00"),
                Text("المحاولات: $attempts"),
              ],
            ),
            const SizedBox(height: 20),
            // شبكة البطاقات
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => flipCard(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardFlips[index] ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        cardFlips[index] ? "" : cards[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // زر التلميح
            ElevatedButton(
              onPressed: useHint,
              child: Text("استخدم تلميح (${3 - hintsUsed} متبقي)"),
            ),
          ],
        ),
      ),
    );
  }
}