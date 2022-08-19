import 'package:flutter/material.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: const [
            Tab(text: "INCOME"),
            Tab(text: "EXPENSE"),
          ],
          controller: _tabController,
        ),
        Expanded(
            child: TabBarView(
          children: const [
            IncomeTab(),
            ExpenseTab(),
          ],
          controller: _tabController,
        ))
      ],
    );
  }
}
