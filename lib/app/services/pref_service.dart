import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static SharedPreferences? pref;

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setLogin(int userId) async {
    await pref!.setBool("isLogin", true);
    await pref!.setInt("currentUserId", userId);
  }

  static bool isLogin() => pref?.getBool("isLogin") ?? false;
  static int getUserId() => pref?.getInt("currentUserId") ?? 0;

  static Future<void> setRole(String role) async {
    await pref!.setString("role", role);
  }

  static String getRole() => pref?.getString("role") ?? "";

  static Future<void> clearRole() async {
    await pref!.remove("role");
  }

  static Future<void> logout() async {
    await pref?.clear();
  }

  static Future<void> setName(String name) async {
    await pref!.setString("userName", name);
  }

  static String getName() => pref?.getString("userName") ?? "";

  static Future<void> setMobile(String mobile) async {
    await pref!.setString("userMobile", mobile);
  }

  static String getMobile() => pref?.getString("userMobile") ?? "";


}