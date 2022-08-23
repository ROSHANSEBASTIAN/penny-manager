import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/category_model.dart';

abstract class CategoryDBFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategoryToDB(CategoryModel newCategory);
}

const String CATEGORY_DB_NAME = "category_db";

class CategoryDB implements CategoryDBFunctions {
  ValueNotifier<List<CategoryModel>> incomeListNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseListNotifier = ValueNotifier([]);

  CategoryDB._internal(); // This is another way of creating constructors in dart. Named construcotr

  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  @override
  Future<void> addCategoryToDB(CategoryModel newCategory) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    int _newId = 0;
    try {
      final _lastCategory = _categoryDB.values.last;
      if (_lastCategory.id == null) {
        _newId = 0;
      } else {
        _newId = _lastCategory.id + 1;
      }
    } catch (e) {
      _newId = 0;
    }

    newCategory.id = _newId;
    print("New category, ID: ${_newId}, NAME: ${newCategory.name}");
    _categoryDB.put(_newId, newCategory);

    if (newCategory.type == CategoryType.expense) {
      expenseListNotifier.value.add(newCategory);
      expenseListNotifier.notifyListeners();
    } else {
      incomeListNotifier.value.add(newCategory);
      incomeListNotifier.notifyListeners();
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshCategroryListNotifiers() async {
    final _allCategories = await getCategories();
    expenseListNotifier.value.clear();
    incomeListNotifier.value.clear();

    Future.forEach(
      _allCategories,
      (CategoryModel category) => {
        if (category.type == CategoryType.expense)
          {
            expenseListNotifier.value.add(category),
          }
        else
          {
            incomeListNotifier.value.add(category),
          }
      },
    );

    incomeListNotifier.notifyListeners();
    expenseListNotifier.notifyListeners();
  }

  Future<void> deleteCategory(CategoryModel selCategory) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.delete(selCategory.id);
    if (selCategory.type == CategoryType.expense) {
      expenseListNotifier.value
          .removeWhere((element) => element.id == selCategory.id);
      expenseListNotifier.notifyListeners();
    } else {
      incomeListNotifier.value
          .removeWhere((element) => element.id == selCategory.id);
      incomeListNotifier.notifyListeners();
    }
  }
}
