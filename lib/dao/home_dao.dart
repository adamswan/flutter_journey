import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:journey/dao/header_util.dart';
import 'package:journey/model/home_model.dart';
import 'package:journey/utils/navigator_util.dart';

class HomeDao {
  static getHomePageData() async {
    var uri = Uri.http("localhost:3000", "/api/home");

    var response = await http.get(uri, headers: await hiHeaders());

    var utf8decoder = const Utf8Decoder(); // 编码转换，解决中文乱码

    var bodyString = utf8decoder.convert(response.bodyBytes);

    if (response.statusCode == 200) {
      // return bodyString;
      final List<dynamic> responseData = json.decode(bodyString);
      // 提取第一个对象中的 data 字段，并构建 HomeModel
      final homeData = responseData[0]['data'];
      return HomeModel.fromJson(homeData);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception('请求失败 $bodyString');
    }
  }
}
