import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hint; // 提示文字
  final ValueChanged<String>? onChanged; // 输入框内容改变
  final bool obscureText; // 是否隐藏输入内容
  final TextInputType? keyboardType; // 键盘类型

  const InputWidget(
    this.hint, {
    super.key,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 实际的输入框
        _input(),

        // 下面白色的分割线
        const Divider(color: Colors.white, height: 1, thickness: 0.5),
      ],
    );
  }

  _input() {
    // 使用内置的 TextField 组件：它内部已经管理好了文本编辑的状态，
    // 你通过 onChanged 就可以监听到每一次输入值的变化
    return TextField(
      // 输入框内容改变
      onChanged: onChanged, // 绑定外部传入的 onChanged 回调函数
      obscureText: obscureText, // 是否隐藏输入内容
      keyboardType: keyboardType, // 键盘类型
      autofocus: !obscureText,
      cursorColor: Colors.white, // 输入框光标颜色
      // 输入框中的文字的样式
      style: const TextStyle(
        fontSize: 17,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),

      // 输入框样式
      decoration: InputDecoration(
        border: InputBorder.none, // 移除原有的边框
        // 输入框提示文字
        hintText: hint,
        // 输入框提示文字样式
        hintStyle: const TextStyle(fontSize: 17, color: Colors.orangeAccent),
      ),
    );
  }
}
