import 'package:flutter/material.dart';

import '../../../screens/home/home_tabs_screen.dart';

class PennyManagerBottomNavigation extends StatelessWidget {
  const PennyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: HomeTabsScreen.homeTabIndexNotifier,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              print("new Index is " + newIndex.toString());
              HomeTabsScreen.homeTabIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Transactions",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Categories",
              ),
            ],
          );
        });
  }
}
