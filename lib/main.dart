import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:islamic_learning_app/firebase_options.dart';
import 'package:islamic_learning_app/screen/Features/splash/splash%20_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تأكد من تهيئة Flutter
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // تأكد من استيراد DefaultFirebaseOptions
  );  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق تعليمي إسلامي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Cairo', // خط مناسب للعربية
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0),
          bodyMedium: TextStyle(fontSize: 14.0),
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
