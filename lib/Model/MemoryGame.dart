class MemoryGame {
  List<String> cards;
  List<bool> cardFlips;
  List<bool> cardMatched;
  int attempts;
  int hintsUsed;
  int matchedPairs;

  MemoryGame({
    required this.cards,
    required this.cardFlips,
    required this.cardMatched,
    required this.attempts,
    required this.hintsUsed,
    required this.matchedPairs,
  });

  // طريقة لإعادة تعيين حالة اللعبة
  void resetGame() {
    cardFlips = List.filled(cards.length, true);
    cardMatched = List.filled(cards.length, false);
    attempts = 0;
    hintsUsed = 0;
    matchedPairs = 0;
  }
}
