import 'dart:async';

import 'package:flutter/cupertino.dart';

class LaunchPagerController with ChangeNotifier {

  var countDownTime = 5;

  Timer? _timer;

  bool isFinish = false;

  void startTimer() {
    if (_timer != null) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      if (countDownTime <= 0) {
        stopTimer();
      } else {
        countDownTime--;
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    isFinish = true;
    notifyListeners();
  }

}
