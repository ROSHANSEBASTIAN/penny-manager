import '../../model/category_model.dart';

abstract class CategoryDBFunctions {
  Future<void> addCategoryToDB(CategoryModel newCategory);
}

class CategoryDB implements CategoryDBFunctions {
  @override
  Future<void> addCategoryToDB(CategoryModel newCategory) async {}
}
