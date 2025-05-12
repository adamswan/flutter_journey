import 'package:journey/dao/login_dao.dart';

hiHeaders() async {
  String? boardingPass = await LoginDao.getBoadringPass();

  Map<String, String> header = {
    "auth-token": "fgjhjsdfnjhdsabfjhdjsajkfdsgfnskdg",
    "couser-flag": "ft",
    'boarding-pass': boardingPass ?? '',
  };
  print('header: $header');
  return header;
}
