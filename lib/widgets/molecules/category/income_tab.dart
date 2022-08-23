import 'package:flutter/material.dart';

import '../../../model/category_model.dart';
import '../../../db/category/category_db.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB.instance.incomeListNotifier,
        builder:
            (BuildContext context, List<CategoryModel> incomeList, Widget? _) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) => Card(
              child: ListTile(
                title: Text(incomeList[index].name),
                trailing: IconButton(
                  onPressed: () => incomeDeleteHandler(incomeList[index]),
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
            itemCount: incomeList.length,
          );
        });
  }

  void incomeDeleteHandler(CategoryModel selCategory) {
    CategoryDB.instance.deleteCategory(selCategory);
  }
}
