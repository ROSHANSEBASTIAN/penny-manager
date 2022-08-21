import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../db/category/category_db.dart';
import '../../../model/category_model.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  TextEditingController _nameController = TextEditingController();
  showDialog(
    context: context,
    builder: (dialogContext) {
      return SimpleDialog(
        title: const Text(
          "Add new category",
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.all(5.0),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "Category name",
            ),
            keyboardType: TextInputType.name,
          ),
          const Divider(
            height: 10,
          ),
          Row(
            children: const [
              RadioButton(title: "Income", type: CategoryType.income),
              RadioButton(title: "Expense", type: CategoryType.expense),
            ],
          ),
          const Divider(
            height: 10,
          ),
          ElevatedButton.icon(
              onPressed: () {
                final _name = _nameController.text;
                if (_name.isEmpty) {
                  return;
                }

                addNewCategory(dialogContext, _name);
              },
              icon: const Icon(Icons.add),
              label: const Text("Add"))
        ],
      );
    },
  );
}

Future<void> addNewCategory(BuildContext dialogContext, String name) async {
  CategoryModel newCategory = CategoryModel(
    name: name,
    type: selectedCategory.value,
  );
  await CategoryDB().addCategoryToDB(newCategory);
  Navigator.of(dialogContext).pop();
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedCategory,
        builder: (BuildContext context, CategoryType selectedType, Widget? _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<CategoryType>(
                value: type,
                groupValue: selectedType,
                onChanged: (updatedType) =>
                    selectedCategory.value = updatedType!,
              ),
              Text(title),
            ],
          );
        });
  }
}
