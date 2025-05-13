import 'package:flutter/material.dart';
import 'package:journey/utils/screen_adapter_helper.dart';
import 'package:journey/utils/view_util.dart';
import 'package:journey/widget/input_widget.dart';
import 'package:journey/utils/string_util.dart';
import 'package:journey/widget/login_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:journey/dao/login_dao.dart';
import 'package:journey/utils/navigator_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false; // 登录按钮是否可用
  String? userName = ''; // 用户名
  String? password = ''; //  密码

  @override
  Widget build(BuildContext context) {
    ScreenHelper.init(context); // 初始化屏幕适配

    return Scaffold(
      resizeToAvoidBottomInset: false, // 键盘弹出时，让输入框不被遮挡
      body: Stack(children: [..._background(), _content()]),
    );
  }

  // 背景组件（包括背景图片、灰色遮罩）
  _background() {
    //  fit: BoxFit.cover 的写法是给 asset() 函数的指定参数传参
    return [
      // Stack 组件的最下层：背景图片
      Positioned.fill(
        child: Image.asset('images/login-bg1.jpg', fit: BoxFit.cover),
      ),

      // 灰色遮罩层
      Positioned.fill(
        child: Container(color: Colors.black.withValues(alpha: 0.3)),
      ),
    ];
  }

  // 账号密码输入框，单独提出来
  _content() {
    // Stack 组件的最上层 登录的输入框
    return Positioned.fill(
      left: 25, // left 表示 距离屏幕左边的距离
      right: 25, // right 表示 距离屏幕右边的距离
      child: ListView(
        children: [
          placeholderBox(height: 100),

          const Text(
            '账号密码登录',
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),

          placeholderBox(height: 40),

          // 账号输入框
          InputWidget(
            '请输入账号',
            onChanged: (val) {
              userName = val; // 取到输入的值
              _checkInput(); // 实时检查登录按钮是否可用
            },
          ),

          placeholderBox(height: 10),

          // 密码输入框
          InputWidget(
            '请输入密码',
            onChanged: (val) {
              password = val; // 取到输入的值
              _checkInput(); // 实时检查登录按钮是否可用
            },
          ),

          placeholderBox(height: 45),

          // 登录按钮
          LoginButton(
            '登录',
            enable: loginEnable,
            onPressed: () => _login(context),
          ),

          placeholderBox(height: 15),

          // 注册按钮
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => {_jumpToRegister()},
              child: const Text(
                '注册账号',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _login(context) async {
    try {
      await LoginDao.login(userName: userName!, password: password!);
      NavigatorUtil.goToHome(context);
    } catch (e) {
      debugPrint('登录失败$e');
    }
  }

  // 用手机默认浏览器跳转注册页（app 与 h5 联动）
  _jumpToRegister() async {
    Uri uri = Uri.parse(
      'https://api.devio.org/uapi/swagger-ui.html#/Account/registrationUsingPOST',
    );

    if (await launchUrl(uri, mode: LaunchMode.externalApplication) == false) {
      throw 'Could not launch $uri';
    }
  }

  // 判断登录按钮是否可用
  void _checkInput() {
    var enable = false;

    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }

    // 更新状态
    setState(() {
      loginEnable = enable;
    });
  }
}
