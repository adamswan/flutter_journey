import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:journey/dao/header_util.dart';
import 'package:journey/utils/navigator_util.dart';

import '../model/search_model.dart';

///搜索接口
class SearchDao {
  static Future<SearchModel?> fetch(String text) async {
    var uri = Uri.http("localhost:3000", "/api/search");

    final response = await http.get(uri, headers: await hiHeaders());

    Utf8Decoder utf8decoder = const Utf8Decoder();

    String bodyString = utf8decoder.convert(response.bodyBytes);

    debugPrint(bodyString);

    if (response.statusCode == 200) {
      var result = json.decode(bodyString);

      SearchModel model = SearchModel.fromJson(result);

      model.keyword = text;

      return model;
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(bodyString);
    }
  }
}
