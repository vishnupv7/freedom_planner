import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freedom_planner/db/category/categorydb.dart';
import 'package:freedom_planner/model/category/category_model.dart';
import 'package:freedom_planner/screens/add%20_transaction/update_transaction.dart';
import 'package:freedom_planner/screens/gragh/my%20graph/graph_methods.dart';
import 'package:intl/intl.dart';

class TransactionDetails extends StatefulWidget {
  String id;
  Color? color;
  final CategoryModel? categoryType;
  final CategoryType? transactionType;
  final String? description;
  final String? imagePath;
  final DateTime? dateTime;
  final String? amount;

  TransactionDetails(
      {required this.id,
      this.categoryType,
      this.transactionType,
      this.description,
      this.imagePath,
      this.dateTime,
      this.amount,
      this.color,
      super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.parse(widget.dateTime.toString());
    final DateFormat formatter2 = DateFormat.yMMMMEEEEd();
    final String formatted = formatter2.format(now);
    final Size = MediaQuery.of(context).size;
    print("------${widget.id}");
    return Scaffold(
       backgroundColor:Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: Size.height,
                width: Size.width,
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0),
                height: Size.height * 0.37,
                width: Size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  color: widget.color,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Detail Transaction",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'lib/assets/images/Indian-Rupee-symbol.svg',
                          width: 40,
                          height: 40,
                          color: Colors.white,
                        ),
                        Text(
                          widget.amount.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 40),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Center(
                        child: Text(
                          "${widget.categoryType!.name} ${widget.transactionType!.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Text(
                          formatted,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: Size.height * 0.32,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                  child: Container(
                    height: 70.0,
                    width: Size.width - 20,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Type",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  widget.transactionType!.name.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Category",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16.0),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  widget.categoryType!.name.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16.0),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Size.height * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 00.0,
                    ),
                    Container(
                      height: 5.0,
                      width: Size.width,
                      //color: Colors.greenAccent,
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.5,
                        dashLength: 10.0,
                        dashColor: Colors.grey.shade300,
                        //dashGradient: [Colors.red, Colors.blue],
                        dashRadius: 2.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          widget.description!.isEmpty
                              ? Container(
                                  child: Center(child: Text("No Description")),
                                )
                              : Container(
                                  width: Size.width - 30,
                                  child: Text(
                                    "   ${widget.description}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attachement",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          widget.imagePath == "123"
                              ? Container(
                                  height: 150.0,
                                  width: Size.width,
                                  child: Center(
                                    child: Text(
                                      "No Attachement!",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: Size.width - 30,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                    image: DecorationImage(
                                        image: FileImage(
                                            File(widget.imagePath.toString())),
                                        fit: BoxFit.cover),
                                  ),
                                  // child: Image.asset(
                                  //   "lib/assets/images/blue.jpg",
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Updatetransaction(
                                  id: widget.id,
                                  amount: widget.amount,
                                  categoryType: widget.categoryType,
                                  transType: widget.transactionType,
                                  dateTime: widget.dateTime,
                                  description: widget.description,
                                  imagePath: widget.imagePath,
                                  //transType: widget.transactionType,
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50.0,
                          width: Size.width - 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.deepPurpleAccent,
                          ),
                          child: Center(
                            child: Text(
                              "Edit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
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
    );
  }
}
