import 'package:flutter/material.dart';

//  加载中效果
class LoadingContainer extends StatelessWidget {
  final Widget child; // 子组件(被压在最下面的真实页面)
  final bool isLoading; // 是否加载中
  final bool cover; // 是否覆盖

  const LoadingContainer({
    super.key,
    required this.child,
    required this.isLoading,
    this.cover = false,
  });

  Widget _showLoadingFace() {
    return Stack(
      //堆叠效果
      children: [child, isLoading ? _genCircularProgress() : Container()],
    );
  }

  // 生成加载中的圆形进度条
  Widget _genCircularProgress() {
    return Center(child: CircularProgressIndicator(color: Colors.blue));
  }

  // 保持原本的样子 不显示圆形进度条
  Widget _stayNormal() {
    if (isLoading) {
      return _genCircularProgress();
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    // 根据传入的cover值来判断是覆盖还是保持原本的样子
    return cover ? _showLoadingFace() : _stayNormal();
  }
}
