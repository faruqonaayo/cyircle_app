import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cyircle_app/models/category.dart';
import 'package:cyircle_app/services/category_service.dart';

class MyCategoryProviderNotifier extends StateNotifier<List<Category>> {
  MyCategoryProviderNotifier() : super([]);

  Future<void> loadCategories() async {
    final categories = await CategoryService().getUserCategories(
      FirebaseAuth.instance.currentUser!.uid,
    );
    state = categories;
  }

  void addCategory(Category category) {
    state = [...state, category];
  }
}

final myCategoryProvider =
    StateNotifierProvider<MyCategoryProviderNotifier, List<Category>>((ref) {
      return MyCategoryProviderNotifier();
    });
