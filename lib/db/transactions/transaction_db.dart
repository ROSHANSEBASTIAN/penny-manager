import 'package:hive_flutter/hive_flutter.dart';

import '../../model/transaction_model.dart';

abstract class TransactionDBFunctions {
  Future<void> addTransaction(TransactionModel newModel);

  void editTransaction(TransactionModel newModel);

  void deleteTransaction(TransactionModel newModel);
}

const String TRANSACTION_DB_NAME = "TRANSACTION_DB_NAME";

class TransactionDB implements TransactionDBFunctions {
  // creating singleton object for TransactionDB class

  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  @override
  Future<void> addTransaction(TransactionModel newModel) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(newModel.id, newModel);
  }

  @override
  Future<void> deleteTransaction(TransactionModel newModel) async {
    // TODO: implement deleteTransaction
  }

  @override
  Future<void> editTransaction(TransactionModel newModel) async {
    // TODO: implement editTransaction
  }
}
