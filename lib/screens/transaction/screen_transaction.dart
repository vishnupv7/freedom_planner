import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:freedom_planner/db/transaction/transactiondb.dart';
import 'package:freedom_planner/global/colors.dart';
import 'package:freedom_planner/model/category/category_model.dart';
import 'package:freedom_planner/screens/add%20_transaction/transaction_detail_screen.dart';
import 'package:intl/intl.dart';

import '../../model/transaction/transaction_model.dart';

class transaction extends StatefulWidget {
  const transaction({Key? key}) : super(key: key);

  @override
  State<transaction> createState() => _transactionState();
}

class _transactionState extends State<transaction> {
  List<String> list = <String>[
    'income',
    'expense',
    'All'
  ];
  List<String> allList = <String>[
    'All',
  ];
  String? dropdownMonth;
  String? dropdownAllList = "All";
  String value2 = "abc";
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('-----$dropdownAllList');
    //String dropdownValue = list.first;
    transactionDb.instance.refreshUI();
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 99, 140, 166),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: appColors,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 18.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Transactions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 45.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.black, width: 1.0)),
                    child: DropdownButton<String>(
                      value: dropdownMonth,
                      hint: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Type",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 30.0,
                      ),

                      //style: const TextStyle(color: Colors.black),
                      underline: Container(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownMonth = value!;
                          dropdownAllList = '';
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          onTap: () {
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      dropdownMonth = null;
                      dropdownAllList = "All";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 45.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.black, width: 1.0)),
                      child: const Center(
                        child: Text(
                          "All",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ValueListenableBuilder(
                valueListenable: transactionDb.instance.transactionlistnotifier,
                builder: (BuildContext ctx, List<transactionmodel> newList,
                    Widget? _) {
                  // ignore: avoid_unnecessary_containers
                  return Container(
                    child: ListView.separated(
                      //padding: const EdgeInsets.all(10),
                      itemBuilder: (ctx, index) {
                        final value = newList[index];
                        //print("------${DateFormat.LLL().format(value.date)}");
                        return Slidable(
                            key: Key(value.id!),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (ctx) {
                                    transactionDb.instance
                                        .deleteTransaction(value.id!);
                                  },
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  backgroundColor: Colors.red,
                                ),
                                SlidableAction(
                                  onPressed: (ctx) {},
                                  icon: Icons.delete,
                                  label: 'edit',
                                  backgroundColor: Colors.blue,
                                )
                              ],
                            ),
                            child: value.type.name == dropdownMonth
                                ? InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TransactionDetails(
                                                    id: value.id.toString(),
                                                    dateTime: value.date,
                                                    description: value.Purpose,
                                                    amount:
                                                        value.amount.toString(),
                                                    transactionType: value.type,

                                                    categoryType:
                                                        value.category,
                                                    // value
                                                    //     .category.name
                                                    //     .toString(),
                                                    color: value.type ==
                                                            CategoryType.income
                                                        ? Colors.green
                                                        : Colors.red,
                                                    imagePath: value.imagePath,
                                                  )));
                                    },
                                    child: cardDesign(
                                      value.category.name,
                                      value.Purpose,
                                      value.amount,
                                      value.type == CategoryType.income
                                          ? Colors.green
                                          : Colors.red,
                                      value.type == CategoryType.income
                                          ? "+"
                                          : "-",
                                      parsedate(value.date),
                                    ))
                                : dropdownAllList == "All"
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TransactionDetails(
                                                        id: value.id.toString(),
                                                        dateTime: value.date,
                                                        description:
                                                            value.Purpose,
                                                        amount: value.amount
                                                            .toString(),
                                                        transactionType:
                                                            value.type,
                                                        categoryType:
                                                            value.category,
                                                        color: value.type ==
                                                                CategoryType
                                                                    .income
                                                            ? Colors.green
                                                            : Colors.red,
                                                        imagePath:
                                                            value.imagePath,
                                                      )));
                                        },
                                        child: cardDesign(
                                          value.category.name,
                                          value.Purpose,
                                          value.amount,
                                          value.type == CategoryType.income
                                              ? Colors.green
                                              : Colors.red,
                                          value.type == CategoryType.income
                                              ? "+"
                                              : "-",
                                          parsedate(value.date),
                                        ),
                                      )
                                    : Container());
                      },
                      itemCount: newList.length,
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardDesign(String categoryType, String description, double amount,
      Color color, String sign, String date) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        height: 100.0,
        padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryType,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '$sign ${amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String parsedate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
