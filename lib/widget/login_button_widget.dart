import 'package:flutter/material.dart';

// 带禁用功能的登录按钮
class LoginButton extends StatelessWidget {
  final String tittle; // 按钮中显示的文字
  final bool enable; // 按钮是否可用
  final VoidCallback? onPressed;

  const LoginButton(
    this.tittle, {
    super.key,
    this.enable = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // 根据 enable 来决定按钮是否可用。不可用传null，按钮就会被禁用
      onPressed: enable ? onPressed : null,
      disabledColor: Colors.white60,
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      height: 45,
      child: Text(tittle, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
