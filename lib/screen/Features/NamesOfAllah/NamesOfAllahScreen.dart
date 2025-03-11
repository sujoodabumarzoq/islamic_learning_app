import 'package:flutter/material.dart';
import 'package:islamic_learning_app/Model/NamesGroup.dart';
import 'package:islamic_learning_app/screen/Features/NamesOfAllah/NamesList.dart';

class NamesOfAllahScreen extends StatefulWidget {
  const NamesOfAllahScreen({Key? key}) : super(key: key);

  @override
  _NamesOfAllahScreenState createState() => _NamesOfAllahScreenState();
}

class _NamesOfAllahScreenState extends State<NamesOfAllahScreen> {
  // قوائم الأسماء
  final List<NamesGroup> groups = [
    NamesGroup(groupName: "المجموعة 1", names: [
      "الرحمن", "الرحيم", "الملك", "القدوس", "السلام", "المؤمن", "المهيمن", "العزيز", "الجبار", "المتكبر",
    ]),
    NamesGroup(groupName: "المجموعة 2", names: [
      "الخالق", "البارئ", "المصور", "الغفار", "القهار", "الوهاب", "الرزاق", "الفتاح", "العليم", "القابض",
    ]),
    NamesGroup(groupName: "المجموعة 3", names: [
      "الباسط", "الخافض", "الرافع", "المعز", "المذل", "السميع", "البصير", "الحكم", "العدل", "اللطيف",
    ]),
  ];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: groups.length, // استخدام عدد المجموعات من Model
      child: Scaffold(
        appBar: AppBar(
          title: const Text("أسماء الله الحسنى"),
          bottom: TabBar(
            tabs: groups.map((group) => Tab(text: group.groupName)).toList(), // استخدام البيانات من Model
          ),
        ),
        body: Column(
          children: [
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
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                children: groups.map((group) {
                  return NamesList(names: group.names, searchQuery: searchController.text);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

