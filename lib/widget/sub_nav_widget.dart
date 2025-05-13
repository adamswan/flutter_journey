import 'package:flutter/material.dart';

import '../model/home_model.dart';
// import '../util/navigator_util.dart';

class SubNavWidget extends StatelessWidget {
  final List<CommonModel>? suNavList;

  const SubNavWidget({super.key, this.suNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(padding: EdgeInsets.all(7), child: _items(context)),
    );
  }

  _items(BuildContext context) {
    if (suNavList == null) return null;

    // 生成渲染的的多个组件
    List<Widget> items = [];

    for (var i = 0; i < suNavList!.length; i++) {
      items.add(_itemSignal(context, suNavList![i]));
    }

    //计算出第一行显示的数量
    int separate = (suNavList!.length / 2 + 0.5).toInt();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, suNavList!.length),
          ),
        ),
      ],
    );
  }

  _itemSignal(BuildContext context, CommonModel model) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // todo: 跳转到h5页面
          // NavigatorUtil.jumpH5(
          //   url: model.url,
          //   statusBarColor: model.statusBarColor,
          //   title: model.title,
          //   hideAppBar: model.hideAppBar,
          // );
        },
        child: Column(
          children: [
            // 上面的图片
            Image.network(model.icon!, width: 25, height: 25),
            // 下面的文字
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(model.title!, style: const TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
