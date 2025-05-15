import 'package:flutter/material.dart';
import 'package:journey/utils/navigator_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiWebView extends StatefulWidget {
  final String? url; // H5 的地址
  final String? statusBarColor; // 状态栏的颜色
  final String? title; // 页面标题
  final bool? hideAppBar; // 是否隐藏顶部的 AppBar
  final bool? backForbid; // 是否隐藏返回按钮, 例如在【我的】页面时，要隐藏返回按钮

  const HiWebView({
    super.key,
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid,
  });

  @override
  State<HiWebView> createState() => _HiWebViewState();
}

class _HiWebViewState extends State<HiWebView> {
  final _catchUrls = [
    'm.ctrip.com/',
    'm.ctrip.com/html5',
    'm.ctrip.com/html5/',
  ];

  String? url;

  //! controller 是插件 webview_flutter 的控制器
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    url = widget.url;

    // 强行使用 https
    if (url != null && url!.contains('ctrip.com')) {
      url = url!.replaceAll('http://', 'https://');
    }

    // 初始化 webview_flutter 的控制器
    _initWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;

    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return PopScope(
      // 处理安卓物理返回按钮
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (await controller.canGoBack()) {
          // 返回当前h5的上一页
          controller.goBack();
        } else {
          // 退出当前页面
          if (context.mounted) NavigatorUtil.pop(context);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            _appBar(
              Color(int.parse('0xff$statusBarColorStr')),
              backButtonColor,
            ),

            Expanded(child: WebViewWidget(controller: controller)),
          ],
        ),
      ),
    );
  }

  _initWebViewController() {
    // 拿到控制器
    controller = WebViewController();

    // 允许执行 JavaScript
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    // 设置背景颜色
    controller.setBackgroundColor(const Color(0x00000000));
    // 设置导航代理
    controller.setNavigationDelegate(
      NavigationDelegate(
        // 加载进度条
        onProgress: (int progress) {
          debugPrint('WebView is loading (progress : $progress%)');
        },

        // 页面开始加载时的回调
        onPageStarted: (String url) {},

        // 页面加载完成的回调
        onPageFinished: (String url) {
          // 页面完全加载完成后，才能执行js
          // 例如处理左边的返回按钮
          _handleBackForbid();
        },

        // 监听 webview_flutter 的错误
        onWebResourceError: (WebResourceError error) {},

        // onNavigationRequest 的作用是：拦截指定页面的跳转，类似VueRouter的路由守卫 beforeEach
        onNavigationRequest: (NavigationRequest request) {
          // 禁止去携程的 h5 首页
          if (_isToH5HomePage(request.url)) {
            NavigatorUtil.pop(context); // 拦截跳转，直接返回上一页
            return NavigationDecision.prevent; // 禁止跳转
          }
          return NavigationDecision.navigate; // 允许跳转，放行
        },
      ),
    );
    // 加载指定 url
    controller.loadRequest(Uri.parse(url!));
  }

  // 隐藏H5自身的返回按钮
  _handleBackForbid() {
    const jsStr =
        "var element = document.querySelector('.animationComponent.rn-view'); element.style.display = 'none';";
    if (widget.backForbid ?? false) {
      controller.runJavaScript(jsStr);
    }
  }

  _isToH5HomePage(String url) {
    bool contain = false;

    for (var value in _catchUrls) {
      if (url.endsWith(value)) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    // 获取刘海屏的安全距离
    double top = MediaQuery.of(context).padding.top;

    if (widget.hideAppBar ?? false) {
      return Container(color: backgroundColor, height: top);
    }

    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, top, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [_backButton(backButtonColor), _title(backButtonColor)],
        ),
      ),
    );
  }

  _backButton(Color backButtonColor) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Icon(Icons.close, color: backButtonColor, size: 26),
      ),
    );
  }

  _title(Color backButtonColor) {
    return Positioned(
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          widget.title ?? '',
          style: TextStyle(color: backButtonColor, fontSize: 20),
        ),
      ),
    );
  }
}
