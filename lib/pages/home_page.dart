import 'package:flutter/material.dart';
import 'package:journey/dao/login_dao.dart';
import 'package:journey/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // with 表示使用混入
  handlePressed() {
    // 退出登录
    return LoginDao.logout();
  }

  // dart 的 get 标记语法,不能有小括号; 而 set 标记语法可以有小括号
  get _logout {
    return TextButton(onPressed: handlePressed, child: Text('退出登录'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 更新导航器的上下文context， 用于退出登录
    NavigatorUtil.updateContext(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('首页'),
        actions: [_logout],
      ),
    );
  }

  @override // 默认为 false，表示不保持页面状态
  bool get wantKeepAlive => true;
}
