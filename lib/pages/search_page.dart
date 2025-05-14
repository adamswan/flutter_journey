import 'package:flutter/material.dart';
import 'package:journey/widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('搜索'), backgroundColor: Colors.white),
      body: Column(children: [SearchBarWidget()]),
    );
  }
}
