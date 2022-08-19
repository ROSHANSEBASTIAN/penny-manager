import 'package:flutter/material.dart';

class ExpenseTab extends StatelessWidget {
  const ExpenseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => Card(
        child: ListTile(
          title: Text("Expense $index"),
          trailing: IconButton(
            onPressed: () => expenseDeleteHandler(),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 5,
      ),
      itemCount: 10,
    );
  }

  void expenseDeleteHandler() {
    print("expenseDeleteHandler");
  }
}
