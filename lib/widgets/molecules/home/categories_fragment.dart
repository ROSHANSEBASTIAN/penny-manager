import 'package:flutter/material.dart';

import '../../../model/category_model.dart';
import '../../../db/category/category_db.dart';
import '../category/expense_tab.dart';
import '../category/income_tab.dart';

class CategoriesFragment extends StatefulWidget {
  const CategoriesFragment({Key? key}) : super(key: key);

  @override
  State<CategoriesFragment> createState() => _CategoriesFragmentState();
}

class _CategoriesFragmentState extends State<CategoriesFragment>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    print("getCategoriesListFromDB");
    getCategoriesListFromDB();
    super.initState();
  }

  Future<void> getCategoriesListFromDB() async {
    print("getCategoriesListFromDB 2");
    await CategoryDB().refreshCategroryListNotifiers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: const [
            Tab(text: "EXPENSE"),
            Tab(text: "INCOME"),
          ],
          controller: _tabController,
        ),
        Expanded(
            child: TabBarView(
          children: const [
            ExpenseTab(),
            IncomeTab(),
          ],
          controller: _tabController,
        ))
      ],
    );
  }
}
