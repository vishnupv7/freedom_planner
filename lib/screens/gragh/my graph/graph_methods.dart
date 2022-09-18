import 'package:flutter/material.dart';
import 'package:freedom_planner/db/transaction/transactiondb.dart';
import 'package:freedom_planner/model/transaction/transaction_model.dart';

import '../../../model/category/category_model.dart';
import '../../home/widget/piechart.dart';

final List<GDPData> gdpDataExpense = <GDPData>[];
final List<GDPData> allExpInc = <GDPData>[];
final List<GDPData> gdpDataIncome = <GDPData>[];

final List<Color> colors = [
  Colors.orange,
  Colors.blue,
  Colors.purple,
  Colors.green,
  Colors.red,
  Colors.lime,
  Colors.pink,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.teal,
  Colors.lightGreen,
  Colors.yellowAccent,
  Colors.indigo,
  Colors.amber,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.yellow,
  Colors.cyan,
  Colors.orange,
  Colors.blue,
  Colors.purple,
  Colors.green,
  Colors.red,
  Colors.lime,
  Colors.pink,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.teal,
  Colors.lightGreen,
  Colors.yellowAccent,
  Colors.indigo,
  Colors.amber,
  Colors.deepOrange,
  Colors.brown,
  Colors.lime,
  Colors.pink,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.teal,
  Colors.lightGreen,
  Colors.yellowAccent,
  Colors.indigo,
  Colors.grey,
  Colors.yellow,
  Colors.cyan,
];
// List<GDPData> getChartData() {
//   final List<GDPData> chartData = [
//     GDPData("Income", 1600, Colors.orange.shade400),
//     GDPData("Expense", 2400, Colors.deepPurple),
//     GDPData("Savings", 3000, Colors.red),
//   ];
//   return chartData;
// }

class GDPData {
  String id;
  final String continent;
  final double gdp;
  Color color;
  double graphvalue;
  GDPData(this.id, this.graphvalue, this.continent, this.gdp, this.color);
}

listen() {
  return ValueListenableBuilder(
    valueListenable: transactionDb.instance.transactionlistnotifier,
    builder: (BuildContext ctx, List<transactionmodel> newList, Widget? _) {
      return SizedBox(
        //height: 190,
        child: ListView.separated(
          itemBuilder: (ctx, index) {
            final value = newList[index];
            double graphvalue = 0.0;
            var percentvalue = 0.0;
            //=====
            if (value.type == CategoryType.expense) {
              graphvalue = (value.amount * 100) / expense.value;
              percentvalue = graphvalue / 100;

              gdpDataExpense.add(GDPData(value.id.toString(), 1,
                  value.category.name, value.amount, colors[index]));
            }
            return Container();
            // print("cal========$graphvalue");
            // print("perc========= $percentvalue");
          },
          itemCount: newList.length,
          separatorBuilder: (ctx, index) {
            return const SizedBox(
              height: 5.0,
            );
          },
        ),
      );
    },
  );
}

List<Listmodel> testList = [];
List<transactionmodel> finalList = [];

// void data() {
//   for (var item in testList) {
//     print("=======${item.category.name}");
//   }
//   testList.where((element) {
//     if (element.category.name == element.category.name) {
//       print("this is rqual====${element.category.name}");
//     }
//     return true;
//   });
// }

class Listmodel {
  String name;
  Color color;
  double amount;
  Listmodel(this.name, this.amount, this.color);
}
