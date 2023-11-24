import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:litchat/manager/Router/app_router_delegate.dart';
import 'package:litchat/r.g.dart';

class MePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MePageState();
}

class _MePageState extends ConsumerState<MePage> {

  void _pushSettingPage() {
    AppRouterDelegate routerDelegate =
        Router.of(context).routerDelegate as AppRouterDelegate;
    routerDelegate.push(name: '/Setting');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('me');
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text('Me'),
        trailing: IconButton(
          icon: Image(image: R.image.navbar_setting_btn()),
          onPressed: _pushSettingPage,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
