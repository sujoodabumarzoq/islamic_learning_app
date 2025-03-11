import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamic_learning_app/Model/UserModel.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // إنشاء حساب جديد
  Future<UserCredential?> signUp(String email, String password, String fullName) async {
    try {
      // إنشاء المستخدم في Firebase Authentication
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // حفظ بيانات المستخدم في Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(), // تاريخ إنشاء الحساب
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("حدث خطأ أثناء إنشاء الحساب: $e");
    }
  }

  // ضافة مستخدم
  Future<void> addUserToFirestore(UserCredential userCredential, String fullName, String email) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'fullName': fullName,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(), // تاريخ إنشاء الحساب
    });
  }


  // تسجيل الدخول
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("حدث خطأ أثناء تسجيل الدخول: $e");
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception("حدث خطأ أثناء تسجيل الخروج: $e");
    }
  }

  // الحصول على المستخدم الحالي
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // الحصول على بيانات المستخدم من Firestore
  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        throw Exception("المستخدم غير موجود");
      }
    } catch (e) {
      throw Exception("حدث خطأ أثناء جلب بيانات المستخدم: $e");
    }
  }

  // تحديث بيانات المستخدم
  Future<void> updateUserProfile(String uid, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('users').doc(uid).update(updatedData);
    } catch (e) {
      throw Exception("حدث خطأ أثناء تحديث بيانات المستخدم: $e");
    }
  }

  // إعادة تعيين كلمة المرور
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("حدث خطأ أثناء إعادة تعيين كلمة المرور: $e");
    }
  }
}