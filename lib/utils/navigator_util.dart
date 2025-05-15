import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey/pages/login_page.dart';
// import 'package:journey/pages/home_page.dart';
import 'package:journey/navigator/tab_navigator.dart';
import 'package:journey/widget/hi_web_view.dart';

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
      MaterialPageRoute(builder: (context) => const TabNavigator()),
    );
  }

  // 跳转到登录页
  static goToLogin() {
    Navigator.pushReplacement(
      _context!,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  static pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      // 退出应用
      SystemNavigator.pop();
    }
  }

  ///跳转H5页面
  static jumpH5({
    BuildContext? context,
    String? url,
    String? title,
    bool? hideAppBar,
    String? statusBarColor,
  }) {
    BuildContext? safeContext;

    if (url == null) {
      debugPrint('url is null jumpH5 failed.');
      return;
    }

    if (context != null) {
      safeContext = context;
    } else if (_context?.mounted ?? false) {
      safeContext = _context;
    } else {
      debugPrint('context is null jumpH5 failed.');
      return;
    }
    Navigator.push(
      safeContext!,
      MaterialPageRoute(
        builder:
            (context) => HiWebView(
              url: url,
              title: title,
              hideAppBar: hideAppBar,
              statusBarColor: statusBarColor,
            ),
      ),
    );
  }
}
