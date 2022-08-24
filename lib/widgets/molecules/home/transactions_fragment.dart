import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../db/category/category_db.dart';
import '../../../model/category_model.dart';
import '../../../db/transactions/transaction_db.dart';
import '../../../model/transaction_model.dart';

class TransactionsFragment extends StatelessWidget {
  const TransactionsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.getAllTransactions();
    CategoryDB.instance.refreshCategroryListNotifiers();

    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext context, List<TransactionModel> transactionsList,
          Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.only(right: 5.0, left: 5.0),
          itemBuilder: (BuildContext context, int index) {
            final _transaction = transactionsList[index];

            return Slidable(
              startActionPane:
                  ActionPane(motion: const DrawerMotion(), children: [
                SlidableAction(
                  onPressed: (ctx) => deleteHandler(_transaction.id),
                  icon: Icons.delete,
                  label: "Delete",
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                )
              ]),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor:
                        _transaction.categoryType == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                    child: Text(
                      parseDate(_transaction.date),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(_transaction.amount.toString()),
                  subtitle: Text(_transaction.purpose),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: transactionsList.length,
        );
      },
    );
  }

  String parseDate(DateTime dateTime) {
    DateFormat format = DateFormat.MMMd();
    final _date = format.format(dateTime);
    final _splittedDate = _date.split(" ");
    return "${_splittedDate.last}\n${_splittedDate.first}";
  }

  void deleteHandler(String id) {
    TransactionDB.instance.deleteTransaction(id);
  }
}
