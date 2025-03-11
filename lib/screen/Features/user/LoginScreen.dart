import 'package:flutter/material.dart';
import 'package:islamic_learning_app/Model/UserModel.dart';
import 'SignUpScreen.dart'; // تأكد من استيراد صفحة إنشاء الحساب

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  UserModel user = UserModel( email: '', password: '');

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // هنا يمكنك إضافة الكود لتسجيل الدخول
      print('Email: ${user.email}');
      print('Password: ${user.password}');
      // إضافة المزيد من المعالجة هنا
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF66BB6A), Color(0xFF1B5E20)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // العودة إلى الشاشة السابقة
                        },
                        child: const Text(
                          "الرجوع",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // شعار التطبيق
                    Center(
                      child: const Icon(
                        Icons.mosque,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,

                      child: const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // حقل البريد الإلكتروني
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "أدخل البريد الإلكتروني",
                        prefixIcon: const Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال البريد الإلكتروني';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'البريد الإلكتروني غير صحيح';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        user.email = value;
                      },
                    ),
                    const SizedBox(height: 16),

                    // حقل كلمة المرور
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "أدخل كلمة المرور",
                        prefixIcon: const Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !passwordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كلمة المرور';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        user.password = value;
                      },
                    ),
                    const SizedBox(height: 16),

                    // زر "نسيت كلمة المرور؟"
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // هنا يمكنك إضافة كود لإعادة تعيين كلمة المرور
                        },
                        child: const Text(
                          "نسيت كلمة المرور؟",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // زر تسجيل الدخول
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text("تسجيل الدخول"),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF66BB6A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // خيارات تسجيل الدخول البديلة
                    Center(child: const Text("أو")),
                    const SizedBox(height: 20),

                    // تسجيل الدخول باستخدام جوجل
                    ElevatedButton.icon(
                      onPressed: () {
                        // هنا يمكنك إضافة كود تسجيل الدخول باستخدام جوجل
                      },
                      icon: const Icon(Icons.g_mobiledata_sharp),
                      label: const Text("تسجيل الدخول باستخدام جوجل"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // تسجيل الدخول باستخدام آبل
                    ElevatedButton.icon(
                      onPressed: () {
                        // هنا يمكنك إضافة كود تسجيل الدخول باستخدام آبل
                      },
                      icon: const Icon(Icons.apple),
                      label: const Text("تسجيل الدخول باستخدام آبل"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // رابط إنشاء حساب جديد
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        },
                        child: const Text(
                          "إنشاء حساب جديد",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    // زر الرجوع
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}