class UserModel {
  String? fullName;
  String email;
  String password;
  int? childAge;

  UserModel({
      this.fullName,
    required this.email,
    required this.password,
    this.childAge,
  });

  // تحويل الكائن إلى JSON (للتخزين في Firebase)
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password, // ⚠️ لا يُفضل تخزين كلمة المرور مباشرة
      'childAge': childAge,
    };
  }

  // إنشاء كائن UserModel من JSON (عند استرجاع البيانات من Firebase)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      childAge: json['childAge'],
    );
  }
}
