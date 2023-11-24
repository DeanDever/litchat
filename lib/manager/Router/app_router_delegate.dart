
import 'package:flutter/material.dart';
import 'package:litchat/business/login/page/launch_page.dart';
import 'package:litchat/business/login/page/login_page.dart';
import 'package:litchat/business/main/page/main_page.dart';
import 'package:litchat/business/me/page/setting_page.dart';

class AppRouterDelegate extends RouterDelegate<List<RouteSettings>> with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {

  final List<Page> _pages = [];

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  List<Page> get currentConfiguration => List.of(_pages);

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {
    debugPrint('setNewRoutePath ${configuration.last.name}');

    _setPath(configuration
        .map((routeSettings) => _createPage(routeSettings))
        .toList());
    return Future.value(null);
  }

  /// 压入新页面显示
  void push({required String name, Object? arguments}) {
    _pages.add(_createPage(RouteSettings(name: name, arguments: arguments)));
    // 通知路由栈，我们的Page列表已经修改了
    notifyListeners();
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  bool canPop() {
    return _pages.length > 1;
  }

  /// 替换当前正在显示的页面
  void replace({required String name, dynamic arguments}) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    push(name: name,arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
    );
  }

  MaterialPage _createPage(RouteSettings routeSettings) {
    Widget child;

    switch (routeSettings.name) {
      case '/':
        child = LaunchPage();
        break;
      case '/Home':
        child = MainPage();
        break;
      case '/Login':
        child = const LoginPage();
        break;
      case '/Setting':
        child = SettingPage();
        break;
      default:
        child = const LoginPage();
    }

    return MaterialPage(
      child: child,
      key: Key(routeSettings.name!) as LocalKey,
      name: routeSettings.name,
      arguments: routeSettings.arguments,
    );
  }

  void _setPath(List<Page> pages) {
    _pages.clear();
    _pages.addAll(pages);

    notifyListeners();
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;

    if (canPop()) {
      _pages.removeLast();
      return true;
    } else {
      return false;
    }
  }
}
