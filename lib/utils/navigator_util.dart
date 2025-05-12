import 'package:flutter/material.dart';
import 'package:journey/pages/login_page.dart';
import 'package:journey/pages/home_page.dart';

class NavigatorUtil {
  // 用于在获取不到context时，设置一个默认的context
  static BuildContext? _context;

  static updateContext(BuildContext context) {
    NavigatorUtil._context = context;
  }

  // 跳转到指定页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  // 跳转到首页
  static goToHome(BuildContext context) {
    // 跳转到首页后，不允许再返回登录页
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // 跳转到登录页
  static goToLogin() {
    Navigator.pushReplacement(
      _context!,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
