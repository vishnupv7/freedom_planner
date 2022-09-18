import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Iconone2 extends StatelessWidget {
  const Iconone2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        width: 48,
        height: 48,decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 248, 239, 239),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
        
        
        child: Image.asset('lib/assets/images/icons8-expense-64.png'),
      ),
    );
  }
}