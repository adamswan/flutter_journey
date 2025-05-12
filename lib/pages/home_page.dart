import 'package:flutter/material.dart';
import 'package:journey/dao/login_dao.dart';
import 'package:journey/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  handlePressed() {
    // 退出登录
    return LoginDao.logout();
  }

  // dart 的 get 标记语法,不能有小括号; 而 set 标记语法可以有小括号
  get _logout {
    return ElevatedButton(onPressed: handlePressed, child: Text('退出登录'));
  }

  @override
  Widget build(BuildContext context) {
    // 更新导航器的上下文context， 用于退出登录
    NavigatorUtil.updateContext(context);
    return Scaffold(appBar: AppBar(title: Text('首页'), actions: [_logout]));
  }
}
