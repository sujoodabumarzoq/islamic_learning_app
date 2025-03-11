class Settings {
  bool isSoundEnabled;
  double volumeLevel;
  String selectedBackground;
  String fontSize;
  bool areNotificationsEnabled;

  Settings({
    required this.isSoundEnabled,
    required this.volumeLevel,
    required this.selectedBackground,
    required this.fontSize,
    required this.areNotificationsEnabled,
  });

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'isSoundEnabled': isSoundEnabled,
      'volumeLevel': volumeLevel,
      'selectedBackground': selectedBackground,
      'fontSize': fontSize,
      'areNotificationsEnabled': areNotificationsEnabled,
    };
  }

  // من JSON
  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      isSoundEnabled: json['isSoundEnabled'] ?? true,
      volumeLevel: json['volumeLevel'] ?? 0.7,
      selectedBackground: json['selectedBackground'] ?? 'default',
      fontSize: json['fontSize'] ?? 'medium',
      areNotificationsEnabled: json['areNotificationsEnabled'] ?? true,
    );
  }
}
