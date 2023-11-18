import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:litchat/business/login/pager/launch_pager.dart';
import 'package:litchat/business/login/pager/login_pager.dart';
import 'package:litchat/business/main/pager/main_pager.dart';
import 'package:litchat/generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routes: {
        '/': (BuildContext context) => const LaunchPager(),
        '/Login': (BuildContext context) => const LoginPager(),
        '/Main': (BuildContext context) => const MainPager(),
      },
    );
  }
}