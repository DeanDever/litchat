
import 'dart:math';
import 'dart:ui';

import 'package:riverpod/riverpod.dart';

class RoomListControlelr extends Notifier<List<Color>> {

  @override
  List<Color> build() {
    return _generateColors();
  }

  Future<void> refreshData() async {
    return Future.delayed(const Duration(seconds: 2), () {
      state = _generateColors();
    });
  }

  Future<int> loadMoreData() async {
    return Future<int>.delayed(const Duration(seconds: 2), (){
     List<Color> colors = [...state];
     List<Color> newColors = _generateColors();
     colors.addAll(newColors);
     state = colors;
      return newColors.length;
    });
  }

  List<Color> _generateColors() {
    return [
      Color.fromRGBO(
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
      Color.fromRGBO(
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
      Color.fromRGBO(
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
      Color.fromRGBO(
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
      Color.fromRGBO(
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
      Color.fromRGBO(
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
      Color.fromRGBO(
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
      Color.fromRGBO(
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
      Color.fromRGBO(
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
    ];
  }
}