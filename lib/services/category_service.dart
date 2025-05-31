import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cyircle_app/models/category.dart';

class CategoryService {
  CategoryService();

  final fireStore = FirebaseFirestore.instance;

  Future<DocumentReference?> saveCategory(Category category) async {
    final newCategoryRef = await fireStore.collection("categories").add({
      "name": category.name,
      "description": category.description,
      "colors": category.colors,
      "userId": category.userId,
    });

    return newCategoryRef;
  }

  Future<List<Category>> getUserCategories(String userId) async {
    final userCategories = await fireStore
        .collection("categories")
        .where("userId", isEqualTo: userId)
        .get();

    final List<Category> userCategoriesList = [];

    for (var doc in userCategories.docs) {
      final data = doc.data();
      userCategoriesList.add(
        Category(
          name: data["name"],
          description: data["description"],
          colors: [...data["colors"]],
          userId: userId,
        ),
      );
    }

    return userCategoriesList;
  }
}
