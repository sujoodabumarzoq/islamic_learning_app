import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamic_learning_app/screen/Features/NamesOfAllah/NameDetailScreen.dart';

import 'package:flutter/material.dart';

class NamesList extends StatelessWidget {
  final List<String> names;
  final String searchQuery; // النص المدخل في حقل البحث

  const NamesList({Key? key, required this.names, required this.searchQuery}) : super(key: key);

  List<String> get filteredNames {
    if (searchQuery.isEmpty) {
      return names; // عرض جميع الأسماء إذا كان حقل البحث فارغًا
    } else {
      return names
          .where((name) => name.contains(searchQuery)) // فلترة الأسماء
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // عدد الأعمدة
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: filteredNames.length, // استخدام الأسماء المفلترة
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NameDetailScreen(
                  name: filteredNames[index],
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star, // رمز بصري
                  color: Colors.orange,
                ),
                const SizedBox(height: 8),
                Text(
                  filteredNames[index],
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}