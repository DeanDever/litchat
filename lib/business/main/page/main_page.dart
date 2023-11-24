import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:litchat/business/chat/page/chat_page.dart';
import 'package:litchat/business/main/model/bottom_bar_item_info.dart';
import 'package:litchat/business/main/page/match_page.dart';
import 'package:litchat/business/me/page/me_page.dart';
import 'package:litchat/business/room/page/room_list_page.dart';

import '../../common/page/keep_alive_wrapper.dart';
import 'package:litchat/r.g.dart';

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  final items = [
    BottomBarItemInfo(
      iconName: R.image.tabbar_main_img(),
      iconSelectedName: R.image.tabbar_main_selected_img(),
    ),
    BottomBarItemInfo(
      iconName: R.image.tabbar_room_img(),
      iconSelectedName: R.image.tabbar_room_selected_img(),
    ),
    BottomBarItemInfo(
      iconName: R.image.tabbar_chat_img(),
      iconSelectedName: R.image.tabbar_chat_selected_img(),
    ),
    BottomBarItemInfo(
      iconName: R.image.tabbar_me_img(),
      iconSelectedName: R.image.tabbar_me_selected_img(),
    ),
  ];

  final pageController = PageController(initialPage: 0);

  final selectProvider = StateProvider<int>((ref) => 0);

  final pages = [
    KeepAliveWrapper(child: MatchPage(), keepAlive: true),
    KeepAliveWrapper(child:RoomListPage(), keepAlive: true),
    KeepAliveWrapper(child:ChatPage(), keepAlive: true),
    KeepAliveWrapper(child:MePage(), keepAlive: true)
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(selectProvider);
    return Scaffold(
      //  不是builder就无法keepAlive
      body: PageView.builder(
        itemCount:pages.length,
        itemBuilder: (context, index) {
        return pages[index];
      },
        // 滑动方向
        scrollDirection: Axis.horizontal,
        //  控制器
        controller: pageController,
        //  反向
        reverse: false,
        //ClampingScrollPhysics 没有回弹  BouncingScrollPhysics 回弹 NeverScrollableScrollPhysics 不允许滚动
        physics: NeverScrollableScrollPhysics(),

        onPageChanged: (index) {
          debugPrint('scroll to $index');
        },
        //每次滑动是否强制切换整个页面，如果为false，则会根据实际的滑动距离显示页面
        pageSnapping: true,
        //为true可缓存前后各一页
        allowImplicitScrolling: true,
        //后面解释
        padEnds: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 32,
          currentIndex: selectedIndex,
          //  选中的颜色
          fixedColor: null,
          //  fixed item宽度不变  shifting 选中后有切换动画 未选中不显示文本 选中显示文本
          type: BottomNavigationBarType.fixed,
          selectedItemColor: null,
          unselectedItemColor: null,
          selectedIconTheme: IconThemeData(size: 32),
          unselectedIconTheme: IconThemeData(size: 32),
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedLabelStyle: null,
          unselectedLabelStyle: null,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: false,
          onTap: (index) {
            ref.read(selectProvider.notifier).state = index;
            pageController.jumpToPage(index);
          },
          items: items.map((item) {
            return BottomNavigationBarItem(
              icon: Image(
                image: item.iconName,
                width: 32,
                height: 32,
              ),
              label: '',
              activeIcon: Image(
                image: item.iconSelectedName,
                width: 32,
                height: 32,
              ),
            );
          }).toList()),
    );
  }
}
