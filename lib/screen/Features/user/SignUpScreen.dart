import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamic_learning_app/Model/UserModel.dart';
import 'package:islamic_learning_app/repositories/auth_repository.dart';
import 'package:islamic_learning_app/screen/Features/home/HomePage.dart';
import 'package:islamic_learning_app/screen/Features/user/LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthRepository _authRepository = AuthRepository();

  UserModel user = UserModel(fullName: '', email: '', password: '');
  String confirmPassword = '';
  bool passwordVisible = false;
  bool termsAccepted = false;

  // دالة للتحقق من صحة المدخلات
  void _submit() async {
    if (_formKey.currentState!.validate() && termsAccepted) {
      try {
        // إنشاء الحساب في Firebase Authentication
        UserCredential? userCredential = await _authRepository.signUp(user.email, user.password, user.fullName!);

        // إضافة بيانات المستخدم إلى Firestore
        await _authRepository.addUserToFirestore(userCredential!, user.fullName!, user.email);

        print('تم إنشاء الحساب بنجاح');

        // الانتقال إلى شاشة تسجيل الدخول بعد إنشاء الحساب
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        print('فشل إنشاء الحساب: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل إنشاء الحساب: ${e.message}'),
          ),
        );
      } catch (e) {
        print('حدث خطأ غير متوقع: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ غير متوقع: $e'),
          ),
        );
      }
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Text(
                      "إنشاء حساب جديد",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // حقل الاسم الكامل
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "أدخل اسمك الكامل",
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال اسمك الكامل';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        user.fullName = value;
                      },
                    ),
                    const SizedBox(height: 16),

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
                          return 'يرجى إدخال بريد إلكتروني صالح';
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
                        } else if (value.length < 8) {
                          return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        user.password = value;
                      },
                    ),
                    const SizedBox(height: 16),

                    // حقل تأكيد كلمة المرور
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "أكد كلمة المرور",
                        prefixIcon: const Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value != user.password) {
                          return 'كلمتا المرور غير متطابقتين';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                    ),
                    const SizedBox(height: 16),

                    // حقل عمر الطفل (اختياري)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "عمر الطفل (اختياري)",
                        prefixIcon: const Icon(Icons.child_care),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    // خانة اختيار الموافقة على الشروط
                    Row(
                      children: [
                        Checkbox(
                          value: termsAccepted,
                          onChanged: (value) {
                            setState(() {
                              termsAccepted = value!;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "أوافق على شروط الاستخدام وسياسة الخصوصية",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // زر "إنشاء حساب"
                    ElevatedButton(
                      onPressed: () {
                        if (termsAccepted) {
                          _submit();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('يرجى الموافقة على الشروط'),
                            ),
                          );
                        }
                      },
                      child: const Text("إنشاء حساب"),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF66BB6A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // خيارات التسجيل البديلة
                    Center(child: const Text("أو")),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // هنا يمكنك إضافة كود تسجيل الدخول باستخدام جوجل
                          },
                          child: const Text("تسجيل باستخدام جوجل"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // هنا يمكنك إضافة كود تسجيل الدخول باستخدام آبل
                          },
                          child: const Text("تسجيل باستخدام آبل"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // رابط تسجيل الدخول
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: const Text(
                          "لديك حساب بالفعل؟ سجل دخولك",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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