
import 'dart:ui';

class LCTLocalizations {

  Locale _locale = Locale('en');

//  单例
  LCTLocalizations._internal() {
    // _locale = Locale('en');
  }

  factory LCTLocalizations() => _instance;

  static final LCTLocalizations _instance = LCTLocalizations._internal();

  Locale get currentLocal {
    return _locale;
  }

}