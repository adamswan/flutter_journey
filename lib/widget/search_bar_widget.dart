import 'package:flutter/material.dart';

// 搜索框的 3 种样式
// 1. home 搜索框在首页
// 2. homeLight 搜索框在首页(白色)
// 3. normal 搜索框在搜索页面的正常样式
enum SearchBarType { home, homeLight, normal }

class SearchBarWidget extends StatefulWidget {
  // 是否隐藏左侧返回按钮
  final bool? hideLeft;

  /// 搜索框类型
  final SearchBarType searchBarType;

  // 搜索框中的提示文字
  final String? hint;

  // 默认内容
  final String? defaultText;

  // 左侧按钮点击回调
  final void Function()? leftButtonClick;

  // 右侧按钮点击回调
  final void Function()? rightButtonClick;

  // 输入框点击回调
  final void Function()? inputBoxClick;

  // 内容变化的回调
  final ValueChanged<String>? onChange;

  const SearchBarWidget({
    super.key,
    this.hideLeft,
    this.searchBarType = SearchBarType.normal,
    this.hint,
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.inputBoxClick,
    this.onChange,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool showClear = false;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    //! 注意：这里的 widget 就是 【class SearchBarWidget】的实例对象
    if (widget.defaultText != null) {
      // 给控制器赋初始值
      _controller.text = widget.defaultText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _normalSearchBar();
  }

  // 在搜索页面的搜索框
  Widget _normalSearchBar() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          /*左侧返回按钮*/
          _wrapTap(_leftBackBtnComponent(), widget.leftButtonClick),

          /*中间输入框*/
          Expanded(child: _inputBox()),

          /*右侧搜索按钮*/
          _wrapTap(_rightSearchBtnComponent(), widget.rightButtonClick),
        ],
      ),
    );
  }

  // 包装下 GestureDector , 参数1是结构，参数2是回调
  _wrapTap(Widget child, void Function()? callback) {
    // 接收子组件和回调函数
    return GestureDetector(onTap: callback, child: child);
  }

  // 左侧返回按钮
  Widget _leftBackBtnComponent() {
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 10, 10, 7),
      child: _backBtn(),
    );
  }

  _backBtn() {
    bool res = widget.hideLeft == null ? true : false;
    if (res) {
      // 如果隐藏
      return Icon(Icons.arrow_back_ios, color: Colors.grey, size: 26);
    }
    return null;
  }

  _inputBox() {
    Color inputBoxColor;

    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(0xffededed);
    }

    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
          widget.searchBarType == SearchBarType.normal ? 5 : 15,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color:
                widget.searchBarType == SearchBarType.normal
                    ? Color(0xffa9a9a9)
                    : Colors.blue,
          ),
          Expanded(child: Container()),
          // todo 清除按钮
        ],
      ),
    );
  }

  _rightSearchBtnComponent() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Text('搜索', style: TextStyle(color: Colors.blue, fontSize: 17)),
    );
  }
}
