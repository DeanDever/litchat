import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:litchat/business/me/entity/setting_function_entity.dart';
import 'package:litchat/business/me/view/setting_cell.dart';
import 'package:litchat/manager/Router/app_router_delegate.dart';
import 'package:litchat/r.g.dart';

class SettingPage extends ConsumerStatefulWidget {

  SettingPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingPageStatue();
}
class _SettingPageStatue extends ConsumerState<SettingPage> {

  final data = [
    SettingFunctionEntity(type: SettingFunction.empty),
    SettingFunctionEntity(type: SettingFunction.language),
    SettingFunctionEntity(type: SettingFunction.empty),
    SettingFunctionEntity(type: SettingFunction.feedback),
    SettingFunctionEntity(type: SettingFunction.tapToRate),
    SettingFunctionEntity(type: SettingFunction.deleteAccount),
    SettingFunctionEntity(type: SettingFunction.empty),
    SettingFunctionEntity(type: SettingFunction.version),
    SettingFunctionEntity(type: SettingFunction.empty),
    SettingFunctionEntity(type: SettingFunction.logout),
  ];

  Route<String> _modalRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return CupertinoModalPopupRoute<String>(
      builder: (context) => ApplyTextOptions(
        child: CupertinoActionSheet(
          title: Text('修改语言'),
          message: null,
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop('English',),
              child: Text('English'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop('Arabic'),
              child: Text('Arabic'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop('Chinese'),
              child: Text('Chinese'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop('Malay'),
              child: Text('Malay'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop('Thai'),
              child: Text('Thai'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop('Turkish'),
              child: Text('Turkish'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(
              context,
            ).pop('Cancel'),
            child: Text('Cancel', style: TextStyle(color: Color(0xFFFF6D6D))),
          ),
        ),
      ),
    );
  }


  void _onTap(BuildContext context,SettingFunction function) {
    switch (function) {
      case SettingFunction.language:
        _changeLanguage();
        break;
      case SettingFunction.feedback:
        _contactUs();
        break;
      case SettingFunction.tapToRate:
        _tapToRate();
        break;
      case SettingFunction.deleteAccount:
        _deleteAccount(context);
        break;
      case SettingFunction.logout:
        _logout(context);
        break;
      case SettingFunction.version:
        break;
      case SettingFunction.empty:
        break;
    }
  }



  void _changeLanguage(){
    // _modalPopupRoute.present();
    Navigator.of(context).push<String>(_modalRoute(context, null));
  }



  void _contactUs() {

  }

  void _tapToRate() {

  }

  void _deleteAccount(BuildContext context){
    AppRouterDelegate routerDelegate = Router.of(context).routerDelegate as AppRouterDelegate;
    routerDelegate.setNewRoutePath([const RouteSettings(name: '/Login')]);
  }

  void _logout(BuildContext context){
    AppRouterDelegate routerDelegate = Router.of(context).routerDelegate as AppRouterDelegate;
    routerDelegate.setNewRoutePath([const RouteSettings(name: '/Login')]);
  }

  void _popPage(BuildContext context) {
    AppRouterDelegate routerDelegate = Router
        .of(context)
        .routerDelegate as AppRouterDelegate;
    routerDelegate.popRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
          icon: Image(image: R.image.navbar_back_btn()),
          onPressed: () {
            _popPage(context);
          },),
        middle: const Text('Settings'),
      ),
      body: Container(color: const Color(0xFFF3F3F5),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Color(0xFFF3F4F5), height: 1,);
          },
          itemBuilder: (context, index) {
            var item = data[index];
            if (item.type == SettingFunction.empty) {
              return const SizedBox(height: 12);
            } else {
              return SettingCell(item: item, onTap: () {
                _onTap(context, item.type);
              });
            }
          },
        ),
      )
    );
  }
}

// Applies text GalleryOptions to a widget
class ApplyTextOptions extends StatelessWidget {
  const ApplyTextOptions({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget widget = MediaQuery(
      data: MediaQuery.of(context).copyWith(),
      child: child,
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: widget,
    );
  }
}