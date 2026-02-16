import 'package:get/get.dart';
import '../../../data/db_helper.dart';
import '../../../routes/app_routes.dart';
import '../../../services/pref_service.dart';

class LoginController extends GetxController {
  final DbHelper db = DbHelper();
  RxBool hidePassword = true.obs;

  String mobile = "";
  String password = "";

  void setMobile(String v) => mobile = v.trim();
  void setPassword(String v) => password = v;
  void togglePassword() => hidePassword.value = !hidePassword.value;

  Future login() async {
    if (mobile.length != 10) {
      Get.snackbar("Error", "Enter a valid 10-digit mobile number");
      return;
    }
    if (password.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters");
      return;
    }

    try {
      final user = await db.loginUser(mobile, password);

      if (user != null) {
        await PrefService.setLogin(user["id"] as int);
        await PrefService.setName(user["name"].toString());
        await PrefService.setMobile(user["mobile"].toString());

        final role = PrefService.getRole();
        if (role == "" || role.isEmpty) {
          Get.offAllNamed(Routes.ROLE);
        } else if (role == "seller") {
          Get.offAllNamed(Routes.SELLER_HOME);
        } else {
          Get.offAllNamed(Routes.BUYER_HOME);
        }
      } else {
        Get.snackbar("Failed", "Invalid credentials");
      }
    } catch (e) {
      Get.snackbar("Error", "Database error: $e");
    }
  }
}