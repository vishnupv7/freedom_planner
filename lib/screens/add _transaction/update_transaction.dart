import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freedom_planner/db/transaction/transactiondb.dart';
import 'package:freedom_planner/global/colors.dart';
import 'package:freedom_planner/screens/category/category.dart';
import 'package:freedom_planner/screens/home/widget/piechart.dart';
import 'package:freedom_planner/screens/transaction/screen_transaction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../db/category/categorydb.dart';
import '../../model/category/category_model.dart';
import '../../model/transaction/transaction_model.dart';
import '../home/widget/animatedbottomnavigationbar.dart';

class Updatetransaction extends StatefulWidget {
  String id;
  final CategoryType? transType;
  final CategoryModel? categoryType;
  final String? description;
  final String? imagePath;
  final DateTime? dateTime;
  final String? amount;
  Updatetransaction(
      {required this.id,
      this.transType,
      this.categoryType,
      this.description,
      this.imagePath,
      this.dateTime,
      this.amount,
      super.key});

  @override
  State<Updatetransaction> createState() => _UpdatetransactionState();
}

class _UpdatetransactionState extends State<Updatetransaction> {
  final _formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  CategoryType? selectedcategorytype;
  CategoryModel? selectedcategorymodel;
  String? categoryID;
  final Purposetexteditingcontroller = TextEditingController();
  final amounteditingcontroller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<String> list = <String>['Income', 'Expense'];
  String? dropdownValue;
  var path = " ";
  @override
  void initState() {
    selectedDate = widget.dateTime;
    descriptionController.text = widget.description.toString();
    amounteditingcontroller.text = widget.amount.toString();
    selectedcategorymodel = widget.categoryType;
    selectedcategorytype = widget.transType;
    path = widget.imagePath.toString();
    categoryID = widget.categoryType!.id;
    super.initState();
  }

  XFile? imageXfile;

  final ImagePicker _imagePicker = ImagePicker();
  Future<void> selectImage() async {
    imageXfile = await _imagePicker.pickImage(source: ImageSource.gallery);
    // getting a directory path for savin
    setState(() {
      path = imageXfile!.path.toString();
      imageXfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 99, 140, 166),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: size.height + 30,
                width: size.width,
                color: Color.fromARGB(255, 56, 82, 98),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 20.0, bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Center(
                        child: const Text(
                          "Update transaction",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 25.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "How much?",
                      style: TextStyle(color: Colors.white70, fontSize: 20.0),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'lib/assets/images/Indian-Rupee-symbol.svg',
                          width: 55,
                          height: 45,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 90.0,
                          width: size.width - 100,
                          child: TextFormField(
                            controller: amounteditingcontroller,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 60.0),
                            decoration: const InputDecoration(
                              hintText: "0",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60.0),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                snackbar1(context, "");
                              } else {
                                return null;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: size.height * 0.33,
                child: Container(
                  // height: size.height * 0.75,
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 99, 140, 166),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white30,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: size.width - 40.0,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            width: size.width - 31,
                            height: 57,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Container(
                              width: size.width,
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: DropdownButton<String>(
                                hint: Text(
                                  ' ${widget.transType!.name}',
                                ),
                                isExpanded: true,
                                underline: Container(),
                                value: dropdownValue,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 30.0,
                                ),
                                onChanged: (String? value) {
                                  if (value == "Income") {
                                    setState(() {
                                      selectedcategorytype =
                                          CategoryType.income;
                                      categoryID = null;
                                    });
                                  } else {
                                    setState(() {
                                      selectedcategorytype =
                                          CategoryType.expense;
                                      categoryID = null;
                                    });
                                  }
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            width: size.width - 31,
                            height: 57,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 280.0,
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        ' ${selectedcategorymodel!.name}',
                                      ),
                                      value: categoryID,
                                      items: selectedcategorytype != null
                                          ? (selectedcategorytype ==
                                                      CategoryType.income
                                                  ? CategoryDB()
                                                      .incomeCategoryListListner
                                                  : CategoryDB()
                                                      .expenseCategoryListListner)
                                              .value
                                              .map((e) {
                                              return DropdownMenuItem(
                                                value: e.id,
                                                child: Text(e.name),
                                                onTap: () {
                                                  selectedcategorymodel = e;
                                                },
                                              );
                                            }).toList()
                                          : null,
                                      onChanged: (selectedValue) {
                                        setState(() {
                                          categoryID = selectedValue;
                                        });
                                      },
                                      onTap: () {},
                                      icon: const Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 30.0,
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Screencategory()));
                                    },
                                    child: const Icon(
                                        Icons.add_circle_outline_outlined),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: TextFormField(
                                  controller: descriptionController,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.teal,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      snackbar1(context, '');
                                    } else {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final selectedDateTemp = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 30)),
                                lastDate: DateTime.now());
                            setState(() {
                              selectedDate = selectedDateTemp;
                            });
                            if (selectedDate == null) {
                              snackbar1(context, "");
                            }
                          },
                          child: Container(
                            width: size.width - 70.0,
                            height: 50,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Center(
                              child: selectedDate != null
                                  ? Text(DateFormat.yMMMMEEEEd()
                                      .format(selectedDate as DateTime))
                                  : const Text("Pick Your Date"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: Container(
                            width: size.width - 70.0,
                            height: 50,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.attach_file_rounded),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  imageXfile != null
                                      ? const Text(
                                          "Image is Selected",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : const Text("Add attachement"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        InkWell(
                          onTap: () async {
                            await addtransaction();
                            await _formkey.currentState!.validate();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              width: size.width - 30.0,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(
                                  13,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addtransaction() async {
    final descriptions = descriptionController.text;
    final amounttext = amounteditingcontroller.text;
    if (amounttext.isEmpty) {
      snackbar1(context, "amount");
      return;
    }
    if (descriptions.isEmpty) {
      snackbar1(context, "description");
      return;
    }
    if (categoryID == null) {
      snackbar1(context, "");
      return;
    }

    if (selectedDate == null) {
      snackbar1(context, "Date");
      return;
    }
    final parsedamount = double.tryParse(amounttext);
    if (parsedamount == null) {
      return;
    }
    if (selectedcategorymodel == null) {
      snackbar1(context, "Category");
      return;
    }
    final model = transactionmodel(
      Purpose: descriptions,
      amount: parsedamount,
      date: selectedDate!,
      type: selectedcategorytype!,
      category: selectedcategorymodel!,
      imagePath: path.toString(),
    );
    transactionDb.instance.deleteTransaction(widget.id);

    await transactionDb.instance.addtransaction(model);
    snackbar2(context, "Transaction is Updated!");

    transactionDb.instance.refreshUI();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => const transaction()));
  }

  Future<void> snackbar(BuildContext ctx) async {
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      content: Text(' New Transaction Added'),
      backgroundColor: Color.fromARGB(255, 13, 180, 75),
    ));
  }

  Future<void> snackbar1(BuildContext ctx, String? msg) async {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      content: Text(' Please enter a valid input ${msg}'),
      backgroundColor: Color.fromARGB(255, 184, 19, 4),
    ));
  }

  Future<void> snackbar2(BuildContext ctx, String? msg) async {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      content: Text(' ${msg}'),
      backgroundColor: Color.fromARGB(255, 184, 19, 4),
    ));
  }
}
