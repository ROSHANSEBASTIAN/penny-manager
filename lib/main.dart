import 'package:flutter/material.dart';
import 'package:penny_manager/constants/route_names.dart';
import 'package:penny_manager/screens/transactions/add_transaction_screen.dart';

import './db/utils.dart';
import './screens/home/home_tabs_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeHiveDB();

  runApp(const PennyManager());
}

class PennyManager extends StatelessWidget {
  const PennyManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeTabsScreen(),
      routes: {addTransactionScreenRoute: (ctx) => AddTransactionScreen()},
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
