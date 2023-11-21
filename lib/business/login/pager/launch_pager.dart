import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:litchat/business/login/controller/launcher_page_controller.dart';
import 'package:litchat/generated/l10n.dart';

class LaunchPager extends ConsumerWidget {

  LaunchPager({super.key});

  final provider = ChangeNotifierProvider<LaunchPagerController>((ref) {
    final controller = LaunchPagerController();
    controller.startTimer();
    return controller;
  });

  void _pushLoginPage(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), (){
      Navigator.pushReplacementNamed(context, '/Login');
    });
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final LaunchPagerController controller = ref.watch<LaunchPagerController>(provider);

    if (controller.isFinish) {
      _pushLoginPage(context);
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/app_launch_img.png'),
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
                    S.of(context).launch_skip_btn(controller.countDownTime),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  onPressed: () {
                    controller.stopTimer();
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

// class LaunchPager extends StatelessWidget {
//   const LaunchPager({super.key});
//
//   void _pushLoginPage(BuildContext context) {
//     Navigator.pushReplacementNamed(context, '/Login');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return ChangeNotifierProvider<LaunchPagerController>(
//       create: (context) {
//         var notifier = LaunchPagerController();
//         notifier.startTimer();
//         if (notifier.isFinish) {
//           _pushLoginPage(context);
//         }
//         return notifier;
//       },
//       builder: (context, _) {
//
//         if (context.select<LaunchPagerController, bool>((value) => value.isFinish)) {
//           Future.delayed(const Duration(milliseconds: 100), (){
//             _pushLoginPage(context);
//           });
//         }
//
//         return Scaffold(
//           body: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/app_launch_img.png'),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 50,
//                   right: 12,
//                   child: SizedBox(
//                     height: 30,
//                     child: CupertinoButton(
//                       color: const Color(0x70FFFFFF),
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       borderRadius: const BorderRadius.all(Radius.circular(15)),
//                       child: Text(
//                         S.of(context).launch_skip_btn(
//                             context.select<LaunchPagerController, int>(
//                                     (value) => value.countDownTime)),
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Color(0xFFFFFFFF),
//                         ),
//                       ),
//                       onPressed: () {
//                         Provider.of<LaunchPagerController>(context, listen: false)
//                             .stopTimer();
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
