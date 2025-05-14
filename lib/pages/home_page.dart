import 'package:flutter/material.dart';
import 'package:journey/dao/login_dao.dart';
import 'package:journey/model/home_model.dart';
import 'package:journey/utils/navigator_util.dart';
import 'package:journey/utils/screen_adapter_helper.dart';
import 'package:journey/widget/banner_widget.dart';
import 'package:journey/dao/home_dao.dart';
import 'package:journey/widget/loading_container.dart';
import 'package:journey/widget/local_nav_list_widget.dart';
import 'package:journey/widget/grid_nav_widget.dart';
import 'package:journey/widget/sub_nav_widget.dart';
import 'package:journey/widget/sale_box_widget.dart';
import 'package:journey/utils/view_util.dart';
import 'package:journey/widget/search_bar_widget.dart';
import 'package:journey/pages/search_page.dart';

const searchBarDefaultText = '网红打卡地 景点 酒店';

class HomePage extends StatefulWidget {
  static Config? configModel;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// with 表示使用混入
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 顶部导航栏的透明度
  double topBarAlpha = 0;
  static const topBarScrollOffset = 100;

  // 首页的数据
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;
  bool _loading = true;

  handlePressed() {
    // 退出登录
    return LoginDao.logout();
  }

  _jumpToSearch() {
    // 跳转到搜索页面
    NavigatorUtil.push(context, const SearchPage());
  }

  // 生成透明度能变化的顶部导航栏
  _genTopBar() {
    // return Opacity(
    //   opacity: topBarAlpha,
    //   child: Container(
    //     height: 80.toFitSize,
    //     decoration: const BoxDecoration(color: Colors.white),
    //     child: const Center(
    //       child: Padding(padding: EdgeInsets.only(top: 20), child: Text('首页')),
    //     ),
    //   ),
    // );

    //获取刘海屏实际的Top 安全边距
    double top = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        shadowWarp(
          child: Container(
            padding: EdgeInsets.only(top: top),
            height: 60 + top,
            decoration: BoxDecoration(
              color: Color.fromARGB((topBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBarWidget(
              searchBarType:
                  topBarAlpha > 0.2
                      ? SearchBarType.homeLight
                      : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              defaultText: searchBarDefaultText,
              rightButtonClick: () {
                LoginDao.logout();
              },
            ),
          ),
        ),
        // bottom line
        Container(
          height: topBarAlpha > 0.2 ? 0.5 : 0,
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)],
          ),
        ),
      ],
    );
  }

  _holdListView() {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,

      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: NotificationListener(
          // 监听 ListView 的滚动事件
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
    );
  }

  _listView() {
    return ListView(
      children: [
        // 轮播图
        BannerWidget(bannerList: bannerList),

        // 球形导航按钮
        LocalNavWidget(localNavList: localNavList),

        // 酒店 机票 旅游 的卡片导航
        if (gridNavModel != null) ...[
          GridNavWidget(gridNavModel: gridNavModel!),
        ] else ...[
          Container(), // 或其他占位组件
        ],

        // 活动的图标按钮入口
        SubNavWidget(suNavList: subNavList),

        // 秒杀专区
        if (salesBoxModel != null) ...[
          SaleBoxWidget(salesBox: salesBoxModel!),
        ] else ...[
          Container(), // 或其他占位组件
        ],

        // 底部导航栏
        _logout,

        SizedBox(height: 800),
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

  // dart 的 get 标记语法,不能有小括号; 而 set 标记语法可以有小括号
  get _logout {
    return TextButton(onPressed: handlePressed, child: Text('退出登录'));
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.getHomePageData();
      setState(() {
        HomePage.configModel = model.config;
        localNavList = model.localNavList ?? [];
        subNavList = model.subNavList ?? [];
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList ?? [];
        _loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  // 获取home数据
  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 更新导航器的上下文context， 用于退出登录
    NavigatorUtil.updateContext(context);

    // 使用背景色能变透明的顶部导航栏
    //
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(children: [_holdListView(), _genTopBar()]),
      ),
    );
  }

  @override // 默认为 false，表示不保持页面状态
  bool get wantKeepAlive => true;
}
