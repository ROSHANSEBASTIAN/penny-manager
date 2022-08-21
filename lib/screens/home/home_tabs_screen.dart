import 'package:flutter/material.dart';

import '../../constants/route_names.dart';
import '../../widgets/molecules/category/category_add_popup.dart';
import '../../widgets/molecules/home/categories_fragment.dart';
import '../../widgets/molecules/home/transactions_fragment.dart';
import '../../widgets/molecules/navigation/penny_manager_bottom_navigation.dart';

class HomeTabsScreen extends StatelessWidget {
  HomeTabsScreen({Key? key}) : super(key: key);

  static ValueNotifier<int> homeTabIndexNotifier = ValueNotifier(0);
  final _fragments = [
    const TransactionsFragment(),
    const CategoriesFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Penny Manager",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: homeTabIndexNotifier,
        builder: (BuildContext context, int index, Widget? _) {
          return _fragments[homeTabIndexNotifier.value];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onFABPressed(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: const PennyManagerBottomNavigation(),
    );
  }

  void onFABPressed(BuildContext context) {
    print("onFABPressed called");
    if (homeTabIndexNotifier.value == 1) {
      showCategoryAddPopup(context);
    } else {
      Navigator.of(context).pushNamed(addTransactionScreenRoute);
    }
  }
}
