import 'package:get/get.dart';
import '../../data/db_helper.dart';
import '../../routes/app_routes.dart';
import '../../services/pref_service.dart';

class ProfileController extends GetxController {
  final db = DbHelper();

  var name = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var location = "".obs;
  var role = "User".obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      role.value = Get.arguments;
    }
    loadProfile();
  }


  Future<void> loadProfile() async {
    final userId = PrefService.getUserId();

    if (userId == 0) return;
    final user = await db.getUserById(userId);

    if (user != null) {
      name.value = user["name"] ?? "";
      email.value = user["email"] ?? "";
      phone.value = user["mobile"] ?? "";
      location.value = user["location"] ?? "";
    }
  }


  void setRole(String userRole) {
    role.value = userRole;
  }

  Future<void> logout() async {
    await PrefService.logout();
    await PrefService.clearRole();
    Get.offAllNamed(Routes.LOGIN);
  }
}