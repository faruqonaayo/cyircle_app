import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyircle_app/models/category.dart';

class CategoryService {
  const CategoryService();

  Future<DocumentReference?> saveCategory(Category category) async {
    final newCategoryRef = await FirebaseFirestore.instance
        .collection("categories")
        .add({
          "name": category.name,
          "description": category.description,
          "colors": category.colors,
          "userId": category.userId,
        });

    return newCategoryRef;
  }
}
