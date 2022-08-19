import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
