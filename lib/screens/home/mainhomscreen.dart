import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freedom_planner/db/category/categorydb.dart';
import 'package:freedom_planner/db/transaction/transactiondb.dart';
import 'package:freedom_planner/db/users/user_database.dart';
import 'package:freedom_planner/global/colors.dart';
import 'package:freedom_planner/model/user/user_model.dart';
import 'package:freedom_planner/screens/home/profile_screen.dart';
import 'package:freedom_planner/screens/home/widget/piechart.dart';
import 'package:intl/intl.dart';
import '../../model/category/category_model.dart';
import '../../model/transaction/transaction_model.dart';

class mainhomescreen extends StatefulWidget {
  const mainhomescreen({Key? key}) : super(key: key);

  @override
  State<mainhomescreen> createState() => _mainhomescreenState();
}

class _mainhomescreenState extends State<mainhomescreen> {
  static DateTime now = DateTime.now();
  static final DateFormat formatter1 = DateFormat.MMMMd();
  static final DateFormat formatter2 = DateFormat('EEEEE', 'en_US');
  final String formatted = formatter2.format(now);
  final String formatted2 = formatter1.format(now);
  String name = "your name";
  String? profileImage;
  readData() async {
    userDatabase user = userDatabase();
    userModel data = await user.readvalues();
    setState(() {
      name = data.userName.toString();
      profileImage = data.profilePic;
    });
  }

  @override
  void initState() {
    readData();
    setState(() {
      now = DateTime.now();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    transactionDb.instance.refreshUI();
    CategoryDB.instance.refresh();
    total();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 99, 140, 166),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 56, 82, 98),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$formatted",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Text(
                                      "$formatted2",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                        name: name,
                                        image: profileImage,
                                      ),
                                    ));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: Colors.red,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            color: Colors.white,
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage: profileImage ==
                                                    null
                                                ? null
                                                : FileImage(File(
                                                    profileImage.toString())),
                                            backgroundColor: Colors.black12,
                                            child: profileImage == null
                                                ? Container(
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                        color: Colors.black26,
                                                        image:
                                                            const DecorationImage(
                                                          image: AssetImage(
                                                            "lib/assets/images/p1.png",
                                                          ),
                                                          fit: BoxFit.cover,
                                                        )),
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        name != null
                                            ? name.toString()
                                            : "Your Name",
                                        style: const TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          height: 110.0,
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                            color: appColors,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Account Balance',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: grandtotal,
                                      builder: (BuildContext context,
                                          double value, Widget? _) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: grandtotal.value < 0
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      'In Loss ',
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 28,
                                                          color: Colors
                                                              .red.shade400,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    SvgPicture.asset(
                                                      'lib/assets/images/Indian-Rupee-symbol.svg',
                                                      width: 35,
                                                      height: 25,
                                                      color: Colors.red,
                                                    ),
                                                    Text(
                                                      ("${grandtotal.value}"),
                                                      style: const TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 30,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'lib/assets/images/Indian-Rupee-symbol.svg',
                                                      width: 35,
                                                      height: 30,
                                                    ),
                                                    Text(
                                                      ("${grandtotal.value}"),
                                                      style: const TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 80,
                              width: 172,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 28, 190, 13),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Income',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Image.asset(
                                            "lib/assets/images/p2.webp",
                                            height: 25.0,
                                            width: 30.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        '${income.value}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Container(
                                height: 80,
                                width: 172,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 247, 82, 67),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Expense',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Image.asset(
                                              "lib/assets/images/p3.webp",
                                              height: 25.0,
                                              width: 30.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          expense.value.toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 350),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 35),
                            child: Text('Recent transaction'),
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable:
                          transactionDb.instance.transactionlistnotifier,
                      builder: (BuildContext ctx,
                          List<transactionmodel> newList, Widget? _) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 190,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(10),
                              itemBuilder: (ctx, index) {
                                final value = newList[index];
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
                                      )
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 0,
                                    child: ListTile(
                                      leading: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Container(
                                          color: Colors.lightBlue,
                                          child: Center(
                                            child: Text(
                                              parsedate(value.date),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text('RS ${value.amount}'),
                                      subtitle: Text(value.category.name),
                                      trailing:
                                          value.type == CategoryType.income
                                              ? const CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  radius: 10,
                                                )
                                              : const CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  radius: 11,
                                                ),
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  newList.length < 3 ? newList.length : 3,
                              separatorBuilder: (ctx, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String parsedate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }
}
