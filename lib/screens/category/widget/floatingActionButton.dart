import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freedom_planner/db/category/categorydb.dart';
import 'package:freedom_planner/model/category/category_model.dart';
import 'package:freedom_planner/model/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategorynotifier =
    ValueNotifier(CategoryType.income);

Future<void> showcategoryAddPop(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: const Color.fromARGB(255, 255, 246, 229),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: const Text(
            'Add Category',
            textAlign: TextAlign.center,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _nameEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Category Name',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 10.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: const [
                  RadioButton(title: 'income', type: CategoryType.income),
                  RadioButton(title: 'expense', type: CategoryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    final name = _nameEditingController.text.trim();
                    if (name.isEmpty) {
                      return;
                    }
                    final Type = selectedCategorynotifier.value;

                    final category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: name,
                      type: Type,
                    );
                    CategoryDB.instance.insertCategory(category);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('add')),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategorynotifier,
          builder: (BuildContext ctx, CategoryType newcategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: selectedCategorynotifier.value,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategorynotifier.value = value;
                selectedCategorynotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
