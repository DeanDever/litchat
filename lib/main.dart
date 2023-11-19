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

import 'network/network_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  network初始化
    _instanceNetwork();

    return MaterialApp(
      title: '',
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // locale: const Locale('cn'),
      routes: {
        '/': (BuildContext context) => const LaunchPager(),
        '/Login': (BuildContext context) => const LoginPager(),
        '/Main': (BuildContext context) => const MainPager(),
      },
    );
  }

  void _instanceNetwork() {
    final String rootUrl;
    if (kReleaseMode) {
      rootUrl = 'https://api.litdate.vip';
    } else {
      rootUrl = 'https://api.litdate.vip';
    }

    NetworkConfiguration configuration = NetworkConfiguration(rootUrl: rootUrl, headerConfigureCallback: () {
      return {};
    }, errorCallback: (NetworkRequest request, NetworkResponse response) {

    });
    NetworkEngine().setConfiguration(configuration);
  }
}