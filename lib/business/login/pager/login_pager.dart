import 'package:flutter/material.dart';

class LoginPager extends StatefulWidget {
  const LoginPager({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPagerState();
}

class _LoginPagerState extends State<LoginPager> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right:0,
            left: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(
              'assets/app_launch_img.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}