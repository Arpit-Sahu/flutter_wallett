import 'package:flutter/material.dart';
import 'package:wallett/Transaction.dart';
import 'package:wallett/testDragableHome.dart';
import 'Dashboard.dart';
import 'package:wallett/Expend.dart';
import 'package:wallett/Credit.dart';
import 'package:wallett/Welcome.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:wallett/bank.dart';
import 'Transaction.dart';
import 'UserProfile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TransactionClassAdapter());
  await Hive.openBox<double>('Money');
  await Hive.openBox<TransactionClass>('Transactions');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Bank>(
      create: (context) => Bank(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Welcome(),
          '/dashboard': (context) => Dashboard(),
          '/expend': (context) => Expend(),
          '/credit': (context) => Credit(),
          '/profile': (context) => UserProfile(),
          '/dragableHome': (context) => DragableHome(),
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
