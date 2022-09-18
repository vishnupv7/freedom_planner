import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:freedom_planner/db/category/categorydb.dart';
import 'package:freedom_planner/db/transaction/transactiondb.dart';
import 'package:freedom_planner/screens/add%20_transaction/add_new_transaction.dart';
import 'package:freedom_planner/screens/gragh/my%20graph/graph.dart';

import '../../add _transaction/screen_addtransaction.dart';
import '../../category/category.dart';
import '../../transaction/screen_transaction.dart';

import '../mainhomscreen.dart';

// const pages = [
//   mainhomescreen(),
//   Screencategory(),
//   ScreenAddTransaction(),
//   transaction(),
//   graph()
// ];

class Moneymanagerbottomnavigation extends StatefulWidget {
  const Moneymanagerbottomnavigation({Key? key}) : super(key: key);

  @override
  State<Moneymanagerbottomnavigation> createState() =>
      _MoneymanagerbottomnavigationState();
}

class _MoneymanagerbottomnavigationState
    extends State<Moneymanagerbottomnavigation> {
  final pages = const [
    mainhomescreen(),
    transaction(),
    AddNewTrasaction(),
    //ScreenAddTransaction(),
    Screencategory(),
    graph(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    transactionDb.instance.refreshUI();
    CategoryDB.instance.refresh();
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
            log(newIndex.toString());
          });
        },
        items: const [
          Icon(
            FontAwesome5.home,
            size: 30,
          ),
          Icon(
            FontAwesome5.exchange_alt,
            size: 30,
          ),
          Icon(
            FontAwesome5.plus,
            size: 30,
          ),
          Icon(
            Icons.category,
            size: 30,
          ),
          Icon(
            FontAwesome5.chart_pie,
            size: 30,
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 99, 140, 166),
        buttonBackgroundColor: const Color.fromARGB(255, 108, 237, 112),
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
