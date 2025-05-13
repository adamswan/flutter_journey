import 'package:flutter/material.dart';
import '../model/home_model.dart';

/// 球区入口
class LocalNavWidget extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNavWidget({super.key, required this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _navItems(context),
      ),
    );
  }

  // 遍历后端返回的数据，生成导航项列表
  List<Widget> _navItems(BuildContext context) {
    if (localNavList.isEmpty) {
      return [];
    }

    List<Widget> items = [];
    for (var i = 0; i < localNavList.length; i++) {
      items.add(_navItem(context, localNavList[i]));
    }

    return items;
  }

  // 生成单个导航项
  Widget _navItem(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        print('点击了');
      },
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              model.icon!,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(model.title!, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
