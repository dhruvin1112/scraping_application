import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../data/db_helper.dart';

class SignupController extends GetxController {
  final DbHelper dbHelper = DbHelper();

  var name = ''.obs;
  var mobile = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var location = ''.obs;
  var hidePassword = true.obs;

  void setName(String v) => name.value = v;
  void setMobile(String v) => mobile.value = v;
  void setEmail(String v) => email.value = v;
  void setPassword(String v) => password.value = v;
  void setLocation(String v) => location.value = v;
  void togglePassword() => hidePassword.value = !hidePassword.value;

  Future<void> signup() async {

    if (name.value.isEmpty ||
        mobile.value.isEmpty ||
        email.value.isEmpty ||
        location.value.isEmpty ||
        password.value.isEmpty) {
      Get.snackbar("Error", "All fields required");
      return;
    }

    if (mobile.value.length != 10) {
      Get.snackbar("Error", "Enter a valid 10-digit mobile number");
      return;
    }

    try {

      final d = await dbHelper.db;


      final List<Map<String, dynamic>> exist = await d.query(
        "users",
        where: "mobile = ?",
        whereArgs: [mobile.value.trim()],
      );

      if (exist.isNotEmpty) {
        Get.snackbar("Error", "Mobile number already registered");
        return;
      }


      await d.insert("users", {
        "name": name.value.trim(),
        "mobile": mobile.value.trim(),
        "email": email.value.trim(),
        "location": location.value.trim(),
        "password": password.value,
      });

      Get.snackbar("Success", "Account created successfully");


      Get.offAllNamed(Routes.LOGIN);

    } catch (e) {
      Get.snackbar("Database Error", "Registration failed: $e");
    }
  }
}