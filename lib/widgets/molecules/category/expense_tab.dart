import 'package:flutter/material.dart';

import '../../../model/category_model.dart';
import '../../../db/category/category_db.dart';

class ExpenseTab extends StatelessWidget {
  const ExpenseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: expenseListNotifier,
        builder:
            (BuildContext context, List<CategoryModel> expenseList, Widget? _) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) => Card(
              child: ListTile(
                title: Text(expenseList[index].name),
                trailing: IconButton(
                  onPressed: () => expenseDeleteHandler(),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 5,
            ),
            itemCount: expenseList.length,
          );
        });
  }

  void expenseDeleteHandler() {
    print("expenseDeleteHandler");
  }
}
