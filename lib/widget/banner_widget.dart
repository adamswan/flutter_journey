import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:journey/model/home_model.dart';
import 'package:journey/utils/screen_adapter_helper.dart';

class BannerWidget extends StatefulWidget {
  final List<CommonModel> bannerList;

  const BannerWidget({super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late int _current; // 当前轮播页码
  late CarouselSliderController _controller; // 轮播控制器

  @override
  void initState() {
    super.initState();
    _current = 0;
    _controller = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items:
              widget.bannerList.map((item) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width, // 设置容器宽度为屏幕宽度
                  child: Image.network(
                    item.icon.toString(),
                    fit: BoxFit.cover, // 使图片覆盖整个容器
                    width: double.infinity, // 图片宽度占满容器
                  ),
                );
              }).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 160.0.toFitSize, // 设置高度
            autoPlay: true, // 自动播放
            enlargeCenterPage: false, // 关闭中间放大效果
            viewportFraction: 1.0, // 每屏只显示一张
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        // 指示器（小圆点）
        Positioned(
          bottom: 10.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                widget.bannerList.asMap().entries.map((entry) {
                  return Container(
                    width: 10.0.toFitSize,
                    height: 10.0.toFitSize,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key ? Colors.white : Colors.grey,
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
