import 'package:hive_flutter/hive_flutter.dart';

import '../model/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType categoryType;

  @HiveField(4)
  final CategoryModel categoryModel;

  @HiveField(5)
  final String id;

  TransactionModel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.categoryType,
    required this.categoryModel,
    required this.id,
  });
}
