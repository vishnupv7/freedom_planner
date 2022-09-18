import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freedom_planner/db/transaction/transactiondb.dart';
import 'package:freedom_planner/global/colors.dart';
import 'package:freedom_planner/model/transaction/transaction_model.dart';
import 'package:freedom_planner/screens/gragh/my%20graph/graph_methods.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../model/category/category_model.dart';
import '../../home/widget/piechart.dart';

class graph extends StatefulWidget {
  const graph({Key? key}) : super(key: key);

  @override
  State<graph> createState() => _graphState();
}

class _graphState extends State<graph> with SingleTickerProviderStateMixin {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late TabController _tabController;
  String transctionId = "";
  double newgraphValue = 0.0;
  Color? color;

  bool isReady = false;
  double exp = 0.0;
  double inc = 0.0;
  double graphExp = 0.0;
  double graphInc = 0.0;

  methoExpVsIncome() {
    allExpInc.clear();
    exp = expense.value * 100 / income.value;
    inc = grandtotal.value * 100 / income.value;
    graphExp = exp / 100;
    graphInc = inc / 100;
    print("data====== $graphExp");
    print("graph====>$graphInc");
    allExpInc.add(
      GDPData("", 0.0, "Income", grandtotal.value, Colors.orange),
    );

    allExpInc.add(
      GDPData(
        "",
        0.0,
        "Expense",
        expense.value,
        Colors.deepPurpleAccent,
      ),
    );
  }

  // readDataExpense() async {
  //   gdpDataExpense.clear();
  //   List<transactionmodel> data =
  //       await transactionDb.instance.getAlltransaction();
  //   int i = 0;
  //   data.forEach((element) {
  //     if (element.type == CategoryType.expense) {
  //       //print('------${element.amount}');
  //       i++;
  //       gdpDataExpense.add(GDPData(element.id.toString(), element.category.name,
  //           element.amount, colors[i]));

  //       setState(() {
  //         gdpDataExpense;
  //       });
  //     }
  //   });
  // }

  // readDataIncome() async {
  //   gdpDataIncome.clear();
  //   List<transactionmodel> data =
  //       await transactionDb.instance.getAlltransaction();
  //   int i = 0;
  //   data.forEach((element) {
  //     if (element.type == CategoryType.income) {
  //       //print('------${element.amount}');
  //       i++;
  //       gdpDataIncome.add(GDPData(element.id.toString(), element.category.name,
  //           element.amount, colors[i]));
  //       setState(() {
  //         gdpDataIncome;
  //       });
  //     }
  //   });
  // }
  List a = [10, 20, 30, 20, 40, 10];
  List b = [];
  @override
  void initState() {
    testList.clear();
    Future.delayed(Duration(milliseconds: 1000), () {
      methoExpVsIncome();

      setState(() {});
    });
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    _chartData = gdpDataExpense;
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 99, 140, 166),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //color: Colors.orange.withOpacity(0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 28.0,
                ),
                const Text(
                  "Financial Report",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                _tabController.index == 0
                    ? SfCircularChart(
                        legend: Legend(
                          isVisible: true,
                        ),
                        annotations: <CircularChartAnnotation>[
                          CircularChartAnnotation(
                              widget: const PhysicalModel(
                                  //child: Container(),
                                  shape: BoxShape.circle,
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  color: Color.fromRGBO(230, 230, 230, 1))),
                          CircularChartAnnotation(
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                // SvgPicture.asset(
                                //   'lib/assets/images/Indian-Rupee-symbol.svg',
                                //   width: 25,
                                //   height: 25,
                                //   color: Colors.black,
                                // ),
                                Text("Income",
                                    //expense.value.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                        fontSize: 15)),
                                Text("Vs",
                                    //expense.value.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 19)),
                                Text("Expense",
                                    //expense.value.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                        fontSize: 15)),
                              ],
                            ),
                          )
                        ],
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries>[
                          DoughnutSeries<GDPData, String>(
                              dataSource: allExpInc,
                              pointColorMapper: (GDPData data, _) => data.color,
                              xValueMapper: (GDPData data, _) => data.continent,
                              yValueMapper: (GDPData data, _) => data.gdp,
                              // dataLabelSettings:
                              //     DataLabelSettings(isVisible: true),
                              innerRadius: "75%",
                              radius: "75%")
                        ],
                      )
                    : _tabController.index == 1
                        ? SfCircularChart(
                            // legend: Legend(
                            //   isVisible: true,
                            // ),
                            annotations: <CircularChartAnnotation>[
                              CircularChartAnnotation(
                                  widget: const PhysicalModel(
                                      //child: Container(),
                                      shape: BoxShape.circle,
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      color: Color.fromRGBO(230, 230, 230, 1))),
                              CircularChartAnnotation(
                                widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'lib/assets/images/Indian-Rupee-symbol.svg',
                                      width: 25,
                                      height: 25,
                                      color: Colors.black,
                                    ),
                                    Text(expense.value.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 25)),
                                  ],
                                ),
                              )
                            ],
                            tooltipBehavior: _tooltipBehavior,
                            series: <CircularSeries>[
                              DoughnutSeries<GDPData, String>(
                                  dataSource: gdpDataExpense,
                                  pointColorMapper: (GDPData data, _) =>
                                      data.color,
                                  xValueMapper: (GDPData data, _) =>
                                      data.continent,
                                  yValueMapper: (GDPData data, _) => data.gdp,
                                  // dataLabelSettings:
                                  //     DataLabelSettings(isVisible: true),
                                  innerRadius: "75%",
                                  radius: "75%")
                            ],
                          )
                        : SfCircularChart(
                            // legend: Legend(
                            //   isVisible: true,
                            // ),
                            annotations: <CircularChartAnnotation>[
                              CircularChartAnnotation(
                                  widget: const PhysicalModel(
                                      //child: Container(),
                                      shape: BoxShape.circle,
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      color: Color.fromRGBO(230, 230, 230, 1))),
                              CircularChartAnnotation(
                                // ignore: avoid_unnecessary_containers
                                widget: Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'lib/assets/images/Indian-Rupee-symbol.svg',
                                      width: 25,
                                      height: 25,
                                      color: Colors.black,
                                    ),
                                    Text(income.value.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 25)),
                                  ],
                                )),
                              )
                            ],
                            tooltipBehavior: _tooltipBehavior,
                            series: <CircularSeries>[
                              DoughnutSeries<GDPData, String>(
                                  dataSource: gdpDataIncome,
                                  pointColorMapper: (GDPData data, _) =>
                                      data.color,
                                  xValueMapper: (GDPData data, _) =>
                                      data.continent,
                                  yValueMapper: (GDPData data, _) => data.gdp,
                                  // dataLabelSettings:
                                  //     DataLabelSettings(isVisible: true),
                                  innerRadius: "75%",
                                  radius: "75%")
                            ],
                          ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: size.width,
                  //color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, top: 25.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30.0),
                          height: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.grey[200]),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              color: Colors.red[400],
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            tabs: const [
                              Tab(
                                child: Text("All"),
                              ),
                              Tab(
                                child: Text("Expense"),
                              ),
                              Tab(
                                child: Text("Income"),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              //========== First -All tab
                              Container(
                                height: MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    linearprogress(
                                      "Icome",
                                      Colors.orange,
                                      graphInc < 0 ? 0.00001 : graphInc,
                                      inc < 0.0
                                          ? 0.0.toStringAsFixed(2)
                                          : inc.toStringAsFixed(2),
                                    ),
                                    linearprogress(
                                      "Expense",
                                      Colors.deepPurpleAccent,
                                      graphExp > 1 ? 1 : graphExp,
                                      exp > 100.0
                                          ? 100.0.toStringAsFixed(2)
                                          : exp.toStringAsFixed(2),
                                    )
                                  ],
                                ),
                              ),
                              //======  tab bar view widget Expense
                              //------
                              Container(
                                child: ValueListenableBuilder(
                                  valueListenable: transactionDb
                                      .instance.transactionlistnotifier,
                                  builder: (BuildContext ctx,
                                      List<transactionmodel> newList, Widget? _) {
                                    int iIncome = 0;
                                    int iExpense = -1;
                                    double sumOfTransaction = 0.0;
                                    gdpDataExpense.clear();
                                    testList.clear();
      
                                    return SizedBox(
                                      //height: 190,
                                      child: ListView.separated(
                                        itemBuilder: (ctx, index) {
                                          final value = newList[index];
                                          double graphvalue = 0.0;
                                          var percentvalue = 0.0;
      
                                          //=====
      
                                          if (value.type ==
                                              CategoryType.expense) {
                                            //iExpense++;
      
                                            graphvalue = (value.amount * 100) /
                                                expense.value;
                                            percentvalue = graphvalue / 100;
      
                                            gdpDataExpense.add(GDPData(
                                                value.id.toString(),
                                                percentvalue,
                                                value.category.name,
                                                value.amount,
                                                colors[index]));
      
                                            double amount = 0.0;
                                          }
      
                                          return value.type ==
                                                  CategoryType.expense
                                              ? linearprogress(
                                                  value.category.name,
                                                  colors[index],
                                                  percentvalue,
                                                  graphvalue.toStringAsFixed(2))
                                              : Container();
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
                                ),
                              ),
      
                              //========= second tab bar viiew Income
                              ValueListenableBuilder(
                                valueListenable: transactionDb
                                    .instance.transactionlistnotifier,
                                builder: (BuildContext ctx,
                                    List<transactionmodel> newList, Widget? _) {
                                  gdpDataIncome.clear();
                                  return SizedBox(
                                    //height: 190,
                                    child: ListView.separated(
                                      //padding: const EdgeInsets.all(2),
                                      itemBuilder: (ctx, index) {
                                        final value = newList[index];
                                        double graphvalue = 0.0;
                                        double percentvalue = 0.0;
                                        if (value.type == CategoryType.income) {
                                          graphvalue =
                                              (value.amount * 100) / income.value;
                                          percentvalue = graphvalue / 100;
      
                                          gdpDataIncome.add(GDPData(
                                              value.id.toString(),
                                              graphvalue,
                                              value.category.name,
                                              value.amount,
                                              colors[index]));
                                        }
      
                                        // print("cal========$graphvalue");
                                        // print("perc========= $percentvalue");
                                        return value.type == CategoryType.income
                                            ? linearprogress(
                                                value.category.name,
                                                colors[index],
                                                percentvalue,
                                                graphvalue.toStringAsFixed(2),
                                              )
                                            : Container();
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
                              ),
                              //---- End of second
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //------widget linera progress
  Widget linearprogress(
      String title, Color color, double graphValue, String graphPercentage) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8.0, left: 30.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 10.0,
                backgroundColor: color,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 40,
            animation: true,
            animationDuration: 1000,
            lineHeight: 20.0,
            // leading: new Text("left content"),
            // trailing: new Text("right content"),
            percent: graphValue,
            center: Text("${graphPercentage} %"),
            barRadius: const Radius.circular(10.0),
            progressColor: color,
            backgroundColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
  //-------end progress

}

// Code for tab all
