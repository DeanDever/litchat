

import 'package:package_info_plus/package_info_plus.dart';

enum SettingFunction {
  empty,
  language,
  feedback,
  tapToRate,
  deleteAccount,
  version,
  logout,
}

class SettingFunctionEntity {

  SettingFunctionEntity({required this.type});

  final SettingFunction type;

  String get title {
    switch (this.type) {
      case SettingFunction.empty:
        return'';
      case SettingFunction.language:
        return 'Language';
      case SettingFunction.feedback:
        return 'Contact us';
      case SettingFunction.tapToRate:
        return 'Tap to rate';
      case SettingFunction.deleteAccount:
        return 'Delete Account';
      case SettingFunction.version:
        return 'Version';
      case SettingFunction.logout:
        return 'Logout';
    }
  }

  Future<String> get value async {
    switch (this.type) {
      case SettingFunction.empty:
        return '';
      case SettingFunction.language:
        return '123123';
      case SettingFunction.feedback:
        return '';
      case SettingFunction.tapToRate:
        return '';
      case SettingFunction.version:
        return PackageInfo.fromPlatform().then((value) => value.version) ;
      case SettingFunction.deleteAccount:
        return '32';
      case SettingFunction.logout:
        return '';
    }
  }
}