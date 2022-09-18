import 'package:flutter/material.dart';
import 'package:freedom_planner/screens/home/widget/animatedbottomnavigationbar.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    checkuserloggedin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 99, 140, 166),
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/assets/images/blue.jpg'))),
        ),
      ),
    );
  }

  Future<void> gotointro() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, 'introductionscreen1');
 
  }

  Future<void> checkuserloggedin() async {
    final share = await SharedPreferences.getInstance();
    final userLoggedIn = share.getBool(saveKeyName);
    if (userLoggedIn == null || userLoggedIn == false) {
      gotointro();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const Moneymanagerbottomnavigation()));
    }
  }
}
