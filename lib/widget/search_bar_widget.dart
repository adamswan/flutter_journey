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
    // 根据传入的  widget.searchBarType 来决定显示样式
    if (widget.searchBarType == SearchBarType.normal) {
      return _normalSearchBar();
    }

    if (widget.searchBarType == SearchBarType.home) {
      return _homeSearchBar();
    }

    return _normalSearchBar();
  }

  // 在首页的搜索框(透明的)
  _homeSearchBar() {
    return Row(
      children: [
        // 左侧显示的当前城市
        _wrapTap(
          Container(
            padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
            child: Row(
              children: [
                Text('北京', style: TextStyle(color: _homeFontColor())),
                Icon(Icons.expand_more, color: _homeFontColor(), size: 22),
              ],
            ),
          ),
          widget.leftButtonClick,
        ),
        // 中间搜索框
        Expanded(child: _inputBox()),
        // 登出按钮
        _wrapTap(
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              '登出',
              style: TextStyle(color: _homeFontColor(), fontSize: 12),
            ),
          ),
          widget.rightButtonClick,
        ),
      ],
    );
  }

  _homeFontColor() {
    if (widget.searchBarType == SearchBarType.homeLight) {
      return Colors.black54;
    }
    return Colors.white;
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

  _onChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }

    if (widget.onChange != null) {
      widget.onChange!(value);
    }
  }

  _textField() {
    if (widget.searchBarType == SearchBarType.normal) {
      return TextField(
        controller: _controller,
        onChanged: _onChanged,
        autofocus: true,
        cursorColor: Colors.blue,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5, bottom: 20, right: 5),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 15),
        ),
      );
    } else {
      return _wrapTap(
        Text(
          widget.defaultText ?? '',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        widget.inputBoxClick,
      );
    }
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
          Expanded(child: _textField()),

          if (showClear)
            _wrapTap(Icon(Icons.clear, size: 22, color: Colors.grey), () {
              setState(() {
                _controller.clear();
              });
              _onChanged('');
            }),
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
