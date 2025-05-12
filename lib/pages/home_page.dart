import 'package:flutter/material.dart';
import 'package:journey/dao/login_dao.dart';
import 'package:journey/utils/navigator_util.dart';
import 'package:journey/utils/screen_adapter_helper.dart';
import 'package:journey/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // with 表示使用混入

  List<String> bannerList = [
    "https://images.unsplash.com/photo-1551782450-a2132b4ba21d",
    "https://images.unsplash.com/photo-1522205408450-add114ad53fe",
    "https://images.unsplash.com/photo-1519125323398-675f0ddb6308",
    "https://images.unsplash.com/photo-1523205771623-e0faa4d2813d",
    "https://images.unsplash.com/photo-1508704019882-f9cf40e475b4",
  ];

  // 顶部导航栏的透明度
  double topBarAlpha = 0;
  static const topBarScrollOffset = 100;

  handlePressed() {
    // 退出登录
    return LoginDao.logout();
  }

  // dart 的 get 标记语法,不能有小括号; 而 set 标记语法可以有小括号
  get _logout {
    return TextButton(onPressed: handlePressed, child: Text('退出登录'));
  }

  // 生成透明度能变化的顶部导航栏
  _genTopBar() {
    return Opacity(
      opacity: topBarAlpha,
      child: Container(
        height: 80.toFitSize,
        decoration: const BoxDecoration(color: Colors.white),
        child: const Center(
          child: Padding(padding: EdgeInsets.only(top: 20), child: Text('首页')),
        ),
      ),
    );
  }

  _listView() {
    return ListView(
      children: [
        BannerWidget(bannerList: bannerList),
        _logout,
        SizedBox(height: 800, child: ListTile(title: Text('123'))),
      ],
    );
  }

  // 监听滚动事件, 通过 offset 判断滚动位置，进而更新导航栏透明度
  _onScroll(offset) {
    var alpha = offset / topBarScrollOffset;

    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      topBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 更新导航器的上下文context， 用于退出登录
    NavigatorUtil.updateContext(context);

    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.blue,
    //     title: Text('首页'),
    //     actions: [_logout],
    //   ),
    //   body: Column(children: [BannerWidget(bannerList: bannerList)]),
    // );

    // 使用背景色能变透明的顶部导航栏
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            // 监听 ListView 的滚动事件
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return false;
              },
              child: _listView(),
            ),
          ),
          _genTopBar(),
        ],
      ),
    );
  }

  @override // 默认为 false，表示不保持页面状态
  bool get wantKeepAlive => true;
}
