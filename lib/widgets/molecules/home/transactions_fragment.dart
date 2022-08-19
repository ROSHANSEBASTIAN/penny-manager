import 'package:flutter/material.dart';

class TransactionsFragment extends StatelessWidget {
  const TransactionsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.orange,
              child: Text(
                "Date",
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text('Amount ${index + 1}'),
            subtitle: const Text(
              "transaction name",
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: 10,
    );
  }
}
