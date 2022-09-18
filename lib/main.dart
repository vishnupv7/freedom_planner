import 'package:freedom_planner/model/user/user_model.dart';
import 'package:freedom_planner/screens/home/widget/animatedbottomnavigationbar.dart';
import 'package:freedom_planner/screens/splash_screen/intro.dart';
import 'package:flutter/material.dart';
import 'package:freedom_planner/model/category/category_model.dart';
import 'package:freedom_planner/model/transaction/transaction_model.dart';
import 'package:freedom_planner/screens/splash_screen/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';

const saveKeyName = 'user_logged_in';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(userModelAdapter().typeId)) {
    Hive.registerAdapter(userModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(transactionmodelAdapter().typeId)) {
    Hive.registerAdapter(transactionmodelAdapter());
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'login sample',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Splash(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        'spalshscreen1': (context) => const Splash(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        'introductionscreen1': (context) => introduction(),
        'mainscreen': (context) => const Moneymanagerbottomnavigation(),
      },
    );
  }
}
