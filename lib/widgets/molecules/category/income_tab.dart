import 'package:flutter/material.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => Card(
        child: ListTile(
          title: Text("Income $index"),
          trailing: IconButton(
            onPressed: () => incomeeDeleteHandler(),
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

  void incomeeDeleteHandler() {}
}
