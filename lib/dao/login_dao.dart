import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:journey/dao/header_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:journey/utils/navigator_util.dart';

// 登录接口
class LoginDao {
  // 作为本地存储用的key
  static const boardingPass = "boarding_pass";

  static login({required String userName, required String password}) async {
    Map<String, String> paramsMap = {};

    paramsMap['username'] = userName;
    paramsMap['password'] = password;

    // var uri = Uri.https("api.devio.org", "/uapi/user/login", paramsMap);

    // 用我自己写的后端服务
    var uri = Uri.http("localhost:3000", "/api/account/login", paramsMap);

    final response = await http.post(uri, headers: await hiHeaders());

    Utf8Decoder utf8decoder = const Utf8Decoder();

    String bodyString = utf8decoder.convert(response.bodyBytes);

    if (response.statusCode == 200) {
      var result = json.decode(bodyString);

      if (result['code'] == 0 && result['data'] != null) {
        // 登录成功 保存登录凭证

        _saveBoardingPass(result['data']);
      } else {
        throw Exception('登录失败');
      }
    } else {
      throw Exception('登录失败');
    }
  }

  // 保存登录凭证
  static void _saveBoardingPass(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(boardingPass, val);
  }

  // 获取登录凭证
  static getBoadringPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = prefs.getString(boardingPass);
    return res;
  }

  static void logout() async {
    // 移除登录凭证
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(boardingPass); // 移除保存的登录凭证
    NavigatorUtil.goToLogin();
  }
}
