// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:freedom_planner/db/transaction/transactiondb.dart';

// import '../../db/category/categorydb.dart';
// import '../../model/category/category_model.dart';
// import '../../model/transaction/transaction_model.dart';
// import '../category/category.dart';

// class Updatetransaction extends StatefulWidget {
//   final String Purpose;
//   final double amount;
//   final DateTime date;
//   final CategoryType type;
//   final CategoryModel category;
//   String? id;
//   Updatetransaction(
//       {Key? key,
//       required this.Purpose,
//       required this.amount,
//       required this.date,
//       required this.type,
//       required this.category})
//       : super(key: key);

//   @override
//   State<Updatetransaction> createState() => _UpdatetransactionState();
// }

// class _UpdatetransactionState extends State<Updatetransaction> {
//   DateTime? selectedDate;
//   CategoryType? selectedcategorytype;
//   CategoryModel? selectedcategorymodel;
//   String? categoryID;
//   final Purposetexteditingcontroller = TextEditingController();
//   final amounteditingcontroller = TextEditingController();
//   @override
//   void initState() {
//     selectedcategorytype = CategoryType.income;

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(children: [
//         Align(
//           alignment: Alignment.topCenter,
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: 150,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(35),
//               color: Color.fromARGB(255, 68, 106, 130),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.only(top: 90),
//               child: Text(
//                 'Add Transaction',
//                 style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 2.0),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//         Align(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 100),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Color.fromARGB(255, 68, 106, 130),
//               ),
//               width: MediaQuery.of(context).size.width,
//               height: 450,
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 30.0),
//                     child: ListTile(
//                       leading: const Icon(FontAwesome5.coins),
//                       title: TextFormField(
//                         controller: amounteditingcontroller,
//                         keyboardType: TextInputType.number,
//                         decoration: new InputDecoration(
//                           hintText: 'Amount',
//                           border: new OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: Colors.teal, width: 1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 110.0),
//                     child: ListTile(
//                       leading: const Icon(FontAwesome5.clipboard),
//                       title: TextFormField(
//                         controller: Purposetexteditingcontroller,
//                         decoration: new InputDecoration(
//                           hintText: 'Purpose',
//                           border: new OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.teal),
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 46, left: 30),
//                     child: Align(
//                       child: TextButton.icon(
//                         onPressed: () async {
//                           final selectedDateTemp = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate:
//                                   DateTime.now().subtract(Duration(days: 30)),
//                               lastDate: DateTime.now());
//                           setState(() {
//                             selectedDate = selectedDateTemp;
//                           });
//                           if (selectedDate == null) {
//                             return;
//                           }
//                         },
//                         icon: const Icon(Icons.calendar_today),
//                         label: Text(selectedDate == null
//                             ? 'Select Date'
//                             : selectedDate!.toString()),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 50, right: 18),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Row(
//                             children: [
//                               Radio(
//                                 value: CategoryType.income,
//                                 groupValue: selectedcategorytype,
//                                 onChanged: (newvalue) {
//                                   setState(() {
//                                     selectedcategorytype = CategoryType.income;
//                                     categoryID = null;
//                                   });
//                                 },
//                               ),
//                               Text(
//                                 'Income',
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Radio(
//                                 value: CategoryType.expense,
//                                 groupValue: selectedcategorytype,
//                                 onChanged: (newvalue) {
//                                   setState(() {
//                                     selectedcategorytype = CategoryType.expense;
//                                     categoryID = null;
//                                   });
//                                 },
//                               ),
//                               Text(
//                                 'Expense',
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Row(children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 160.0, left: 100),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 5),
//                         width: 200,
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(255, 99, 140, 166),
//                             borderRadius: BorderRadius.circular(
//                               30,
//                             ),
//                             border: Border.all(width: 3)),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             hint: Text(
//                               'Select Category',
//                               textAlign: TextAlign.center,
//                             ),
//                             value: categoryID,
//                             items: (selectedcategorytype == CategoryType.income
//                                     ? CategoryDB().incomeCategoryListListner
//                                     : CategoryDB().expenseCategoryListListner)
//                                 .value
//                                 .map((e) {
//                               return DropdownMenuItem(
//                                 value: e.id,
//                                 child: Text(e.name),
//                                 onTap: () {
//                                   selectedcategorymodel = e;
//                                 },
//                               );
//                             }).toList(),
//                             onChanged: (selectedValue) {
//                               setState(() {
//                                 categoryID = selectedValue;
//                               });
//                             },
//                             onTap: () {},
//                             icon: const Padding(
//                                 padding: EdgeInsets.only(left: 20),
//                                 child: Icon(Icons.arrow_circle_down_sharp)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Align(
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 170, left: 10),
//                           child: IconButton(
//                             onPressed: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => Screencategory()));
//                             },
//                             icon: Icon(Icons.add_box_rounded),
//                             iconSize: 40,
//                           ),
//                         ),
//                       ),
//                     )
//                   ]),
//                   Align(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 320),
//                       child: SizedBox(
//                         width: 180,
//                         height: 40,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             addtransaction();
//                           },
//                           child: Text('Update'),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ]),
//     );
//   }

//   Future<void> addtransaction() async {
//     final purposeText = Purposetexteditingcontroller.text;
//     final amounttext = amounteditingcontroller.text;
//     if (purposeText.isEmpty) {
//       return;
//     }
//     if (amounttext.isEmpty) {
//       return;
//     }
//     if (categoryID == null) {
//       return;
//     }

//     if (selectedDate == null) {
//       return;
//     }
//     final parsedamount = double.tryParse(amounttext);
//     if (parsedamount == null) {
//       return;
//     }
//     if (selectedcategorymodel == null) {
//       return;
//     }
//     final model = transactionmodel(
//       Purpose: purposeText,
//       amount: parsedamount,
//       date: selectedDate!,
//       type: selectedcategorytype!,
//       category: selectedcategorymodel!,
//     );
//     await transactionDb.instance.updateTransaction(model);
//   }
// }


