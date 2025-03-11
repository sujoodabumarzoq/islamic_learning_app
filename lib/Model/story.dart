class Story {
  final String title;
  final String difficulty;
  final bool isCompleted;
  final String content;
  final String audio; // إضافة خاصية audio
  final String animation; // إضافة خاصية animation
  final List<Map<String, String>> interactiveButtons; // إضافة خاصية interactiveButtons

  Story({
    required this.title,
    required this.difficulty,
    required this.isCompleted,
    required this.content,
    required this.audio,
    required this.animation,
    required this.interactiveButtons,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      title: json['title'],
      difficulty: json['difficulty'],
      isCompleted: json['isCompleted'],
      content: json['content'],
     audio: json['audio'],
     animation: json['animation'],
      interactiveButtons: (json['interactiveButtons'] as List)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );
  }

}

//factory Story.fromJson(Map<String, dynamic> json) {
//   return Story(
//     title: json['title'],
//     difficulty: json['difficulty'],
//     isCompleted: json['isCompleted'],
//     content: json['content'],
//     audio: json['audio'],
//     animation: json['animation'],
//     interactiveButtons: List<Map<String, String>>.from(json['interactiveButtons']),
//   );
// }