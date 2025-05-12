// 底部的tab切换栏
import 'package:flutter/material.dart';
import 'package:journey/pages/home_page.dart';
import 'package:journey/pages/my_page.dart';
import 'package:journey/pages/search_page.dart';
import 'package:journey/pages/travel_page.dart';

// 首页底部的导航 tab 栏
class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  // 导航 tab 的控制器
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        // physics: NeverScrollableScrollPhysics(), // 禁止横向滑动
        children: [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
    );
  }
}
