import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:litchat/business/login/pager/launch_pager.dart';
import 'package:litchat/business/login/pager/login_pager.dart';
import 'package:litchat/business/main/pager/main_pager.dart';
import 'package:litchat/generated/l10n.dart';
import 'package:litchat/network/network_configuration.dart';
import 'package:litchat/network/network_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:litchat/network/network_request.dart';

import 'manager/LCTLocalizations.dart';
import 'network/network_response.dart';
import 'package:litchat/business/common/extension/string_extension.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  network初始化
    _instanceNetwork(context);

    return MaterialApp(
      title: '',
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: LCTLocalizations().currentLocal,
      routes: {
        '/': (BuildContext context) => const LaunchPager(),
        '/Login': (BuildContext context) => const LoginPager(),
        '/Main': (BuildContext context) => const MainPager(),
      },
    );
  }

  void _instanceNetwork(BuildContext context) {

    final String rootUrl;
    if (kReleaseMode) {
      rootUrl = 'http://api-litchat.gzshujiu.com';
    } else {
      rootUrl = 'https://api.litdate.vip';
    }

    String appVersion = '1.0.0';
    PackageInfo.fromPlatform().then((value) {
      appVersion = value.version;
    });

    String platform = 'unknow';
    String IDFA = 'unknow';
    String UUID = 'unknow';
    String deviceName = 'unknow';
    String osVersion = 'unknow';
    String country = 'unknow';
    String language = 'unknow';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    switch (Theme.of(context).platform){
      case TargetPlatform.android:
        platform ='ANDROID';
        deviceInfo.androidInfo.then((value) {
          deviceName = value.model;
          UUID = value.fingerprint;
          osVersion = '${value.version.sdkInt}';
        });
        break;
      case TargetPlatform.iOS:
        platform ='IOS';
        deviceInfo.iosInfo.then((value) {
          deviceName = value.utsname.machine;
          osVersion = value.utsname.sysname;
        });
        break;
      default:
        break;
    }

    NetworkConfiguration configuration = NetworkConfiguration(
    rootUrl: rootUrl, headerConfigureCallback: (request) {
    int ts = DateTime
        .now()
        .millisecondsSinceEpoch;

    String uid = '';
    String area = 'PH';

    var headers = {
    'udid': UUID,
    'gaid': IDFA,
    'device': deviceName,
    'osversion': osVersion,
    'platform': platform,
    'channel': "APPLE",
    'appversion': appVersion,
    'country': country,
    'language': language,
    'timestamp': ts,
    'client_language': LCTLocalizations().currentLocal.languageCode.toUpperCase()
    };

    if (uid.isNotEmpty) {
    headers["userid"] = uid;
    }

    String signStr = _generateNetworkSignature(request.api.uri, UUID, uid, request.params, ts);
    if (signStr.isNotEmpty) {
    headers["sign"] = signStr;
    }

    headers['area'] = area;
    return headers;
    }, errorCallback: (NetworkRequest request, NetworkResponse response) {

    });
    NetworkEngine().setConfiguration(configuration);

  }

  String _generateNetworkSignature(String uri, String UUID, String uid,
      Map<String, dynamic>? params, int ts) {
    String paramsEncodeStr = _encodeParams(params);
    String signStr = "${uri}\$${UUID}${uid}${ts}\$${paramsEncodeStr}&secret=dfghjkl&^%%#\$^%%&^*&23dx";

    return signStr.md5String();
  }

  String _encodeParams(Map<String, dynamic>? params) {
    if (params == null) {
      return '';
    }

    var keys = params!.keys.toList();
    keys.sort((s1, s2) => s1.compareTo(s2));

    String res = '';
    for (String key in keys) {
      Object value = params![key];
      if (value is List) {
        continue;
      } else if (value is Map) {
        continue;
      } else if (res.isEmpty) {
        res = '${key}=${value}';
      } else {
        res + '&${key}=${value}';
      }
    }
    return res;
  }
}