import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

import '../../MyApp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyApplication()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/img/logo.png',
              scale: 2,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'p h o n e a c c s'.toUpperCase(),
            style:
                AppTextStyles.getTitleSize().copyWith(color: backgroundColor),
          )
        ],
      ),
    );
  }
}
