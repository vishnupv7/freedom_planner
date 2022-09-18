import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freedom_planner/db/category/categorydb.dart';
import 'package:freedom_planner/screens/category/incomelistview.dart';

import '../../model/category/category_model.dart';

class Expensecategorylist extends StatelessWidget {
   const Expensecategorylist({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expenseCategoryListListner,
      builder: (BuildContext ctx, List<CategoryModel> newwList, Widget? _) {
        return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final category = newwList[index];
              return Card(
                  elevation: 0,
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      onPressed: () {
              _showDialog(context, category.id);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ));
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(
                height: 20,
              );
            },
            itemCount: newwList.length);
      },
    );
  }

  _showDialog(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: const Text('Confirm'),
            content: const Text('Are you sure you want to delete?'),
            actions: [
              TextButton(
                onPressed: () {
                  CategoryDB.instance.deletecategory(id);

                  Navigator.of(context).pop();
                },
                child: const Text(
                  'YES',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'NO',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
