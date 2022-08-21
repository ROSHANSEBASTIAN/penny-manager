import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 0)
enum CategoryType {
  @HiveField(0)
  income,

  @HiveField(1)
  expense
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final CategoryType type;

  @HiveField(2)
  bool isDeleted;

  @HiveField(3)
  String id;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    this.isDeleted = false,
  });
}
