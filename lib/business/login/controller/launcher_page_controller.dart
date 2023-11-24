import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LaunchPagerController extends Notifier<int> {

  Timer? _timer;

  @override
  int build() {
    return 3;
  }

  void startTimer() {
    if (_timer != null) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _decrement();
      if (state <= 0) {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    if (state != 0) {
      state = 0;
    }
  }

  void _decrement() {
    state--;
  }

}
