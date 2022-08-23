import 'package:hive_flutter/hive_flutter.dart';

import '../model/transaction_model.dart';
import '../model/category_model.dart';

// to initialize Hive DB and to register its adapters

Future<void> initializeHiveDB() async {
  await Hive.initFlutter();

  // registering adapters if they are not registered yet
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
}
