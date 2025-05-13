import 'package:flutter/material.dart';
import '../model/home_model.dart';

class SaleBoxWidget extends StatelessWidget {
  final SalesBox salesBox;

  const SaleBoxWidget({super.key, required this.salesBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: const BoxDecoration(color: Colors.white),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];

    // 第1行: 两个大卡片
    items.add(
      _doubleItem(context, salesBox.bigCard1!, salesBox.bigCard2!, true, false),
    );

    // 第2行: 两个小卡片
    items.add(
      _doubleItem(
        context,
        salesBox.smallCard1!,
        salesBox.smallCard2!,
        false,
        false,
      ),
    );

    // 第3行: 两个小卡片
    items.add(
      _doubleItem(
        context,
        salesBox.smallCard3!,
        salesBox.smallCard4!,
        false,
        false,
      ),
    );

    return Column(
      children: [
        _titleItem(), // 顶部横向标题
        // 第1行: 两个大卡片
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        // 第2行: 两个小卡片
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        // 第3行: 两个小卡片
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }

  // 成对的卡片
  // leftCard 左侧卡片，rightCard 右侧卡片，big 是否为大卡片，last 是否为最后一行卡片
  Widget _doubleItem(
    BuildContext context,
    CommonModel leftCard,
    CommonModel rightCard,
    bool big,
    bool last,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 左侧卡片
        _genCard(context, leftCard, big, true, last),
        // 右侧卡片
        _genCard(context, rightCard, big, false, last),
      ],
    );
  }

  //! 生成卡片，包括大的和小的。卡片本质就是一个装图片的盒子。图片里即有画面又有文字
  // left 是否为左侧卡片，big 是否为大卡片，last 是否为最后一行卡片
  Widget _genCard(
    BuildContext context,
    CommonModel model,
    bool big,
    bool left,
    bool last,
  ) {
    BorderSide borderSide = const BorderSide(
      width: 0.8,
      color: Color(0xfff2f2f2),
    );

    double width = MediaQuery.of(context).size.width / 2 - 10;

    return GestureDetector(
      onTap: () {
        // todo  跳转H5页面
        // NavigatorUtil.jumpH5(
        //   url: model.url,
        //   statusBarColor: model.statusBarColor,
        //   title: model.title,
        //   hideAppBar: model.hideAppBar,
        // );
      },

      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: left ? borderSide : BorderSide.none,
            bottom: last ? BorderSide.none : borderSide,
          ),
        ),

        child: Stack(
          children: [
            // 图片
            Image.network(
              model.icon!,
              fit: BoxFit.cover,
              width: width,
              height: big ? 136 : 80,
            ),
            // 文字
            Text(
              model.title.toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  ///活动Item
  _titleItem() {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xfff2f2f2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(salesBox.icon!, height: 15, fit: BoxFit.cover),
          _moreItem(),
        ],
      ),
    );
  }

  /// 顶部横向的标题栏
  _moreItem() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xffff4e63), Color(0xffff6cc9)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          //todo 跳转H5
        },
        child: const Text(
          '获取更多福利 >',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}
