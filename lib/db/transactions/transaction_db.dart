import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/transaction_model.dart';

abstract class TransactionDBFunctions {
  Future<List<TransactionModel>> getAllTransactions();

  Future<void> addTransaction(TransactionModel newModel);

  void editTransaction(TransactionModel newModel);

  void deleteTransaction(String id);
}

const String TRANSACTION_DB_NAME = "TRANSACTION_DB_NAME";

class TransactionDB implements TransactionDBFunctions {
  // creating singleton object for TransactionDB class
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  // value notifier
  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel newModel) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(newModel.id, newModel);
    refreshUI(_db);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _db.delete(id);
    refreshUI(_db);
  }

  @override
  Future<void> editTransaction(TransactionModel newModel) async {}

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    final _list = _db.values.toList();
    refreshUI(_db);
    return _list;
  }

  void refreshUI(Box<TransactionModel> db) {
    final _list = db.values.toList();
    _list.sort((first, second) => first.date.compareTo(second.date));
    transactionListNotifier.value = _list;
    transactionListNotifier.notifyListeners();
  }
}
