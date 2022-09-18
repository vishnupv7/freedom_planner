import 'package:flutter/cupertino.dart';
import 'package:freedom_planner/model/category/category_model.dart';
import 'package:freedom_planner/model/transaction/transaction_model.dart';
import 'package:freedom_planner/screens/home/widget/piechart.dart';
import 'package:freedom_planner/screens/transaction/screen_transaction.dart';
import 'package:hive_flutter/adapters.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunction {
  Future<void> addtransaction(transactionmodel obj);
  Future<List<transactionmodel>> getAlltransaction();
  Future<void> deleteTransaction(String id);
  Future<void>updateTransaction(transactionmodel obj);
}

class transactionDb implements TransactionDbFunction {
  transactionDb._internal();

  static transactionDb instance = transactionDb._internal();
  factory transactionDb() {
    return instance;
  }
  ValueNotifier<List<transactionmodel>> transactionlistnotifier =
      ValueNotifier([]);
        ValueNotifier<List<transactionmodel>> incomeTransactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<transactionmodel>> expenseTransactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addtransaction(transactionmodel obj) async {
    final db = await Hive.openBox<transactionmodel>(TRANSACTION_DB_NAME);
    transactionlistnotifier.notifyListeners();
    await db.put(obj.id, obj);

  }

  Future<void> refreshUI() async {
    final List = await getAlltransaction();
    List.sort((first, second) => second.date.compareTo(first.date));
    transactionlistnotifier.value.clear();
    transactionlistnotifier.value.addAll(List);
    transactionlistnotifier.notifyListeners();
  }

  @override
  Future<List<transactionmodel>> getAlltransaction() async {
    final db = await Hive.openBox<transactionmodel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<transactionmodel>(TRANSACTION_DB_NAME);
    await db.delete(id);
    refreshUI();
  }
  
  @override
  Future<void> updateTransaction(transactionmodel obj) async {
     final db = await Hive.openBox<transactionmodel>(TRANSACTION_DB_NAME);
      await db.put(obj.id, obj);
      getAlltransaction();
  
  }
  Future<void> refreshAllTransactions() async {
    final _allTransactions = await getAlltransaction();
    _allTransactions.sort((first, second) => second.date.compareTo(first.date));
    
    expenseTransactionListNotifier.value.clear();
    await Future.forEach(
      _allTransactions,
      (transactionmodel category) {
        if (category.type == CategoryType.income) {
          incomeTransactionListNotifier.value.add(category);
        } else {
          expenseTransactionListNotifier.value.add(category);
        }
      },
    );
    incomeTransactionListNotifier.notifyListeners();
    expenseTransactionListNotifier.notifyListeners();
  }
  Future<void> refreshTransactions({dat}) async {
    final _allTransactions = await getAlltransaction();
    _allTransactions.sort((first, second) => second.date.compareTo(first.date));
    incomeTransactionListNotifier.value.clear();
    expenseTransactionListNotifier.value.clear();
    await Future.forEach(
      _allTransactions,
      (transactionmodel category) {
        if (category.type == CategoryType.income &&
            parseDate(category.date) == dat) {
          incomeTransactionListNotifier.value.add(category);
        } else if (category.type == CategoryType.expense &&
           parseDate(category.date) == dat) {
          expenseTransactionListNotifier.value.add(category);
        }
      },
    );
    incomeTransactionListNotifier.notifyListeners();
    expenseTransactionListNotifier.notifyListeners();
  }


}