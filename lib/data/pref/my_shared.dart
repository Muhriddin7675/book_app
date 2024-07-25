import 'package:shared_preferences/shared_preferences.dart';

class MyShared {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setHasLogin(bool hasLogin) async {
    prefs.setBool("LOGIN", hasLogin);
  }

  bool getHasLogin() {
    return prefs.getBool("LOGIN") ?? false;
  }

  void saveEmail(String email) {
    prefs.setString("EMAIL", email);
  }

  String? getEmail() => prefs.getString("EMAIL");

  void saveImage(String imagePath) {
    prefs.setString("IMAGE", imagePath);
  }

  String? getImage() => prefs.getString("IMAGE");
}
