import 'dart:io';

class UserProfile {
  File? image;
  int age;
  String currentChild;

  UserProfile({
    this.image,
    required this.age,
    required this.currentChild,
  });
}
