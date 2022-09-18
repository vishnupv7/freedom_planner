import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import '../../model/category/category_model.dart';

const CATEGORY_DB_NAME = 'category_database';

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deletecategory(String categoryID);
}

class CategoryDB implements CategoryDbFunction {
  CategoryDB._internal();

  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListner =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListner =
      ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await CategoryDB.put(value.id, value);
    refresh();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _CategoryDB.values.toList();
  }

  Future<void> refresh() async {
    final all_category = await getCategories();
    incomeCategoryListListner.value.clear();
    expenseCategoryListListner.value.clear();
    await Future.forEach(all_category, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListListner.value.add(category);
      } else {
        expenseCategoryListListner.value.add(category);
      }
    });
    incomeCategoryListListner.notifyListeners();
    expenseCategoryListListner.notifyListeners();
  }

  @override
  Future<void> deletecategory(String categoryID) async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await CategoryDB.delete(categoryID);
    refresh();
    
  }
}
