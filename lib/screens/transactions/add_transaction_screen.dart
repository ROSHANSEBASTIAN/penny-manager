import 'package:flutter/material.dart';

import '../../db/transactions/transaction_db.dart';
import '../../model/transaction_model.dart';
import '../../db/category/category_db.dart';
import '../../model/category_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  CategoryModel? _selCategory;
  CategoryType? _selCategoryType;
  DateTime? _selDate = null;
  final _purposeController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    _selCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: _purposeController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: "Purpose",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Amount",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
                onPressed: () => datePickerClickHandler(context),
                icon: const Icon(Icons.date_range_outlined),
                label: Text(
                    _selDate == null ? "Select Date" : _selDate.toString())),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selCategoryType,
                      onChanged: (CategoryType? updatedType) => setState(() {
                        if (updatedType != null) {
                          setState(() {
                            _selCategory = null;
                            _selCategoryType = updatedType;
                          });
                        }
                      }),
                    ),
                    Text("Income")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selCategoryType,
                      onChanged: (CategoryType? updatedType) => setState(() {
                        if (updatedType != null) {
                          print("Dropdown selection changed");
                          _selCategoryType = updatedType;
                        }
                      }),
                    ),
                    Text("Expense")
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
                valueListenable: _selCategoryType == CategoryType.expense
                    ? CategoryDB().expenseListNotifier
                    : CategoryDB().incomeListNotifier,
                builder: (BuildContext context,
                    List<CategoryModel> categoryList, Widget? _) {
                  return DropdownButton<CategoryModel>(
                    value: _selCategory,
                    hint: const Text("Select Category"),
                    onChanged: (CategoryModel? value) {
                      setState(() {
                        _selCategory = value;
                      });
                    },
                    items: categoryList
                        .map<DropdownMenuItem<CategoryModel>>(
                            (category) => DropdownMenuItem(
                                  child: Text(category.name),
                                  value: category,
                                ))
                        .toList(),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => addOrEditTransaction(context),
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> datePickerClickHandler(BuildContext context) async {
    final _selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
    );
    if (_selectedDate != null) {
      setState(() {
        _selDate = _selectedDate;
      });
    }
  }

  Future<void> addOrEditTransaction(BuildContext context) async {
    print("Adding data to Hive DB 1");
    print(_purposeController.text.trim());
    print(_amountController.text.trim());
    print(_selCategory);
    print(_selCategoryType);
    print(_selDate);

    if (_purposeController.text.trim().isEmpty ||
        _amountController.text.trim().isEmpty ||
        _selCategory == null ||
        _selCategoryType == null ||
        _selDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are mandatory"),
        ),
      );
      return;
    }
    print("Adding data to Hive DB 2");
    double _parsedAmount = double.parse(_amountController.text.trim());
    if (_parsedAmount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please check your amount"),
        ),
      );
      return;
    }
    print("Adding data to Hive DB 3");
    TransactionModel transactionModel = TransactionModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      purpose: _purposeController.text.trim(),
      amount: _parsedAmount,
      date: _selDate!,
      categoryType: _selCategoryType!,
      categoryModel: _selCategory!,
    );
    print("Adding data to Hive DB 4");
    TransactionDB.instance.addTransaction(transactionModel);
    print("Adding data to Hive DB 5");
    Navigator.of(context).pop();
  }
}
