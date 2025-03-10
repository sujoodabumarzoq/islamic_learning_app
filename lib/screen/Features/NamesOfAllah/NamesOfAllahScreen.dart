import 'package:flutter/material.dart';
import 'package:islamic_learning_app/screen/Features/NamesOfAllah/NamesList.dart';
import 'package:flutter/material.dart';
import 'package:islamic_learning_app/screen/Features/NamesOfAllah/NamesList.dart';

import 'package:flutter/material.dart';
import 'package:islamic_learning_app/screen/Features/NamesOfAllah/NamesList.dart';

class NamesOfAllahScreen extends StatefulWidget {
  const NamesOfAllahScreen({Key? key}) : super(key: key);

  @override
  _NamesOfAllahScreenState createState() => _NamesOfAllahScreenState();
}

class _NamesOfAllahScreenState extends State<NamesOfAllahScreen> {
  // قوائم الأسماء للمجموعات
  final List<String> group1Names = [
    "الرحمن", "الرحيم", "الملك", "القدوس", "السلام", "المؤمن", "المهيمن", "العزيز", "الجبار", "المتكبر",
  ];
  final List<String> group2Names = [
    "الخالق", "البارئ", "المصور", "الغفار", "القهار", "الوهاب", "الرزاق", "الفتاح", "العليم", "القابض",
  ];
  final List<String> group3Names = [
    "الباسط", "الخافض", "الرافع", "المعز", "المذل", "السميع", "البصير", "الحكم", "العدل", "اللطيف",
  ];

  TextEditingController searchController = TextEditingController(); // تحكم لحقل البحث

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // عدد المجموعات
      child: Scaffold(
        appBar: AppBar(
          title: const Text("أسماء الله الحسنى"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "المجموعة 1"),
              Tab(text: "المجموعة 2"),
              Tab(text: "المجموعة 3"),
            ],
          ),
        ),
        body: Column(
          children: [
            // حقل البحث
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "ابحث عن اسم",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // تحديث الواجهة عند تغيير النص
                },
              ),
            ),
            // عرض الأسماء في TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  // قائمة الأسماء للمجموعة 1 مع البحث
                  NamesList(names: group1Names, searchQuery: searchController.text),
                  // قائمة الأسماء للمجموعة 2 مع البحث
                  NamesList(names: group2Names, searchQuery: searchController.text),
                  // قائمة الأسماء للمجموعة 3 مع البحث
                  NamesList(names: group3Names, searchQuery: searchController.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}