import 'package:shared_preferences/shared_preferences.dart';

class UserClass {
  static String userToken = 'USERTOKEN';
  static String userNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';

  static Future<bool?> getUserStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userToken);
  }
}
