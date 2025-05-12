import 'package:flutter/material.dart';

// 屏幕适配工具类，如果UI要求要和UI稿完全一致的还原度时可以使用
class ScreenHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double ratio;

  // 根据设计稿实际宽度初始化
  // baseWidth 设计稿宽度
  static void init(BuildContext context, {double baseWidth = 375}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    ratio = screenWidth / baseWidth;
  }

  // 获取设计稿对应的大小
  static double getFitSize(double size) {
    return ScreenHelper.ratio * size;
  }
}

// 定义了一个名为 IntFit 的扩展，作用于 int 类型
extension IntFit on int {
  // 定义了一个名为 toFitSize 的 getter（获取器）属性
  double get toFitSize {
    // 将 int 类型的值转换为 double（通过 toDouble() 方法），
    // 然后调用 ScreenHelper.getFitSize 方法进行屏幕适配计算。
    return ScreenHelper.getFitSize(toDouble());
  }
}

// 定义了一个名为 IntFit 的扩展，作用于 double 类型
extension DoubleFit on double {
  double get toFitSize {
    return ScreenHelper.getFitSize(this);
  }
}
