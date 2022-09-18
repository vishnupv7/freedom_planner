import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../main.dart';
import '../Intro_screen/page1.dart';
import '../Intro_screen/page2.dart';
import '../home/widget/animatedbottomnavigationbar.dart';

class introduction extends StatelessWidget {
  introduction({Key? key}) : super(key: key);
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 99, 140, 166),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    width: 500,
                    child: PageView(
                      controller: _controller,
                      children: const [
                        Page1(),
                        Page2(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 170),
              child: SmoothPageIndicator(
                controller: _controller,
                count: 2,
                effect: JumpingDotEffect(
                  activeDotColor: Colors.deepPurple,
                  dotColor: Colors.deepPurple.shade100,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 16,
                  verticalOffset: 50,
                  jumpScale: 1,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 90, left: 90),
              child: Text(
                'Simple solution for \nyour budget.',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 95),
              child: SizedBox(
                width: 200.0,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                 checkLogin(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 6, 0, 7),
                  ),
                  child: const Text('Skip'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final share = await SharedPreferences.getInstance();
    await share.setBool(saveKeyName, true);

    Navigator.of(ctx).pushReplacement(MaterialPageRoute(
        builder: (ctx1) => const Moneymanagerbottomnavigation()));
  }
}
