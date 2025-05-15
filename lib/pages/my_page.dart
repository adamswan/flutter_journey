import 'package:flutter/material.dart';
import 'package:journey/widget/hi_web_view.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的'), backgroundColor: Colors.blue),
      body: const HiWebView(
        url: 'https://www.doubao.com/',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '0176ac',
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
