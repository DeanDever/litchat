
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:litchat/business/login/controller/launcher_page_controller.dart';
import 'package:litchat/generated/l10n.dart';
import 'package:litchat/manager/Router/app_router_delegate.dart';
import 'package:litchat/r.g.dart';

class LaunchPage extends ConsumerWidget {

  final timerProvider = NotifierProvider<LaunchPagerController, int>(() {
    var controller = LaunchPagerController();
    controller.startTimer();
    return controller;
  });

  LaunchPage({super.key});

  void _pushLoginPage(BuildContext context) {
    AppRouterDelegate routerDelegate = Router.of(context).routerDelegate as AppRouterDelegate;
    routerDelegate.replace(name: '/Login');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(time);
    final countDownTime = ref.watch(timerProvider);
    ref.listen(timerProvider, (previous, next) {
      if (next <= 0) {
        _pushLoginPage(context);
      }
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: R.image.app_launch_img(),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
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
                    S.of(context).launch_skip_btn(countDownTime),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  onPressed: () {
                    ref.read(timerProvider.notifier).stopTimer();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
