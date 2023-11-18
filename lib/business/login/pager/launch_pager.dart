import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:litchat/generated/l10n.dart';

class LaunchPager extends StatefulWidget {
  const LaunchPager({super.key});

  @override
  State<StatefulWidget> createState() => _LaunchPagerState();
}

class _LaunchPagerState extends State<LaunchPager> with SingleTickerProviderStateMixin {

  Timer? _timer;

  int _countDownTime = 5;

  @override
  void initState() {
    _startCountDownTimer();
    super.initState();
  }

  void _startCountDownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countDownTime--;
      });
      if (_countDownTime == 0) {
        _stopTimer();
        _pushLoginPager();
      }
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void _pushLoginPager() {
    Navigator.pushReplacementNamed(context, '/Login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(
              'assets/app_launch_img.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 50,
            right: 12,
            child: SizedBox(
              height: 30,
              child: CupertinoButton(
                color: const Color(0x70FFFFFF),
                padding: const EdgeInsets.only(left: 10, right: 10),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Text(
                  S.of(context).launch_skip_btn(_countDownTime),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                onPressed: (){
                  _stopTimer();
                  _pushLoginPager();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}