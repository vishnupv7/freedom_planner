import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ClipRRect(

          borderRadius: BorderRadius.circular(10),
          child:Image.asset("lib/assets/images/secondone.jpg")
        ),
      ),
    );
  }
}