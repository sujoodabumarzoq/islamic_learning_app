import 'package:flutter/material.dart';
import 'package:islamic_learning_app/Model/MemoryGame.dart';
import 'package:islamic_learning_app/screen/Features/MemoryGameScreen/ResultScreen.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({Key? key}) : super(key: key);

  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  late MemoryGame game;

  @override
  void initState() {
    super.initState();
    game = MemoryGame(
      cards: ['A', 'A', 'B', 'B', 'C', 'C', 'D', 'D', 'E', 'E', 'F', 'F'],
      cardFlips: List.filled(12, true),
      cardMatched: List.filled(12, false),
      attempts: 0,
      hintsUsed: 0,
      matchedPairs: 0,
    );
  }

  void flipCard(int index) {
    setState(() {
      game.cardFlips[index] = !game.cardFlips[index];
    });

    List<int> flippedIndices = [];
    for (int i = 0; i < game.cardFlips.length; i++) {
      if (!game.cardFlips[i] && !game.cardMatched[i]) {
        flippedIndices.add(i);
      }
    }

    if (flippedIndices.length == 2) {
      game.attempts++;
      if (game.cards[flippedIndices[0]] == game.cards[flippedIndices[1]]) {
        game.cardMatched[flippedIndices[0]] = true;
        game.cardMatched[flippedIndices[1]] = true;
        game.matchedPairs++;

        if (game.matchedPairs == game.cards.length ~/ 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                time: 120,
                attempts: game.attempts,
              ),
            ),
          );
        }
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            game.cardFlips[flippedIndices[0]] = true;
            game.cardFlips[flippedIndices[1]] = true;
          });
        });
      }
    }
  }

  void useHint() {
    if (game.hintsUsed < 3) {
      setState(() {
        game.hintsUsed++;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("الوقت: 00:00"),
                Text("المحاولات: ${game.attempts}"),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: game.cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => flipCard(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: game.cardFlips[index] ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        game.cardFlips[index] ? "" : game.cards[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: useHint,
              child: Text("استخدم تلميح (${3 - game.hintsUsed} متبقي)"),
            ),
          ],
        ),
      ),
    );
  }
}
