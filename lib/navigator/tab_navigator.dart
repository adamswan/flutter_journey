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

  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,

        physics: NeverScrollableScrollPhysics(), // 禁止横向滑动
        // 底部导航栏对应的页面
        children: [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
      // 底部导航栏的按钮
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _genItem('首页', Icons.home, 0),
          _genItem('搜索', Icons.search, 1),
          _genItem('旅拍', Icons.camera, 2),
          _genItem('我的', Icons.person, 3),
        ],
      ),
    );
  }

  BottomNavigationBarItem _genItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }
}
