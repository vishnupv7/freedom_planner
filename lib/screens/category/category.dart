import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freedom_planner/db/category/categorydb.dart';
import 'package:freedom_planner/global/colors.dart';
import 'package:freedom_planner/screens/category/expenselist.dart';
import 'package:freedom_planner/screens/category/incomelistview.dart';
import 'package:freedom_planner/screens/category/widget/floatingActionButton.dart';

class Screencategory extends StatefulWidget {
  const Screencategory({Key? key}) : super(key: key);

  @override
  State<Screencategory> createState() => _ScreencategoryState();
}

class _ScreencategoryState extends State<Screencategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refresh();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Color.fromARGB(255, 68, 106, 130)),
              child: const Padding(
                padding: EdgeInsets.only(top: 90),
                child: Text(
                  'CATEGORY',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.only(top: 170.0),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: 'INCOME'),
                      Tab(
                        text: 'EXPENSE',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Incomecategorylist(),
                        Expensecategorylist(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 10),
              child: FloatingActionButton(
                onPressed: () {
                  showcategoryAddPop(context);
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
