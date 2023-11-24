
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:litchat/business/common/extension/color_extension.dart';
import 'package:litchat/business/room/controller/room_list_controller.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../view/room_list_cell.dart';

class RoomListPage extends ConsumerStatefulWidget {
  const RoomListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomListPageState();
}

class _RoomListPageState extends ConsumerState<RoomListPage> {

  /*SliverGridDelegateWithFixedCrossAxisCount
  * 横轴为固定数量子元素的layout算法
  * SliverGridDelegateWithMaxCrossAxisExtent
  * 横轴子元素为固定最大长度的layout算法
  * */
  final _gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    //  列数
    crossAxisCount: 2,
    //  宽高比
    childAspectRatio: 1.0,
    //  垂直间距
    mainAxisSpacing: 10,
    //  水平间距
    crossAxisSpacing: 10,
  );

  final _refreshController = RefreshController(initialRefresh: false);

  final _dataProvider = NotifierProvider<RoomListControlelr, List<Color>>(
      () => RoomListControlelr());

  void _onRefresh() async {
    ref.read(_dataProvider.notifier).refreshData().whenComplete(() {
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    });
  }

  void _onLoading() async {
    ref.read(_dataProvider.notifier).loadMoreData().then((value) {
      if (value >= 20) {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    }).catchError((err) {
      _refreshController.loadFailed();
    });
  }

  void _onTapCell(int index, Color color) {

    Fluttertoast.showToast(
        msg: '--点击 $index Cell--',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: color.invertColor(),
        fontSize: 14.0
    );
  }


  @override
  Widget build(BuildContext context) {
    debugPrint('rooms');
    var data = ref.watch(_dataProvider);
    return Scaffold(
      appBar: const CupertinoNavigationBar(middle: Text('Rooms')),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: true,
        header: const ClassicHeader(),
        footer: CustomFooter(builder: (context, mode) {
          Widget body;
          switch (mode) {
            case LoadStatus.idle:
              body = const Text("上拉加载");
              break;
            case LoadStatus.loading:
              body = const CupertinoActivityIndicator();
              break;
            case LoadStatus.failed:
              body = const Text("加载失败！点击重试！");
              break;
            case LoadStatus.canLoading:
              body = const Text("松手,加载更多!");
              break;
            default:
              body = const Text("没有更多数据了!");
              break;
          }

          return SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width, 55),
            child: Center(child: body),
          );
        }),
        child: GridView.builder(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          gridDelegate: _gridDelegate,
          itemBuilder: (context, index) {
            Color color = data[index];
            return RoomListCell(
                color: color,
                tap: () {
                  _onTapCell(index, color);
                });
          },
          itemCount: data.length,
        ),
      ),
    );
  }
}
