import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/pref_service.dart';

class RoleSelectController extends GetxController {

  var selectedRole = 0.obs;

  Future<void> selectSeller() async {
    selectedRole.value = 1;
    await Future.delayed(const Duration(milliseconds: 300));
    await PrefService.setRole("seller");
    Get.offAllNamed(Routes.SELLER_HOME);
  }

  Future<void> selectBuyer() async {
    selectedRole.value = 2;
    await Future.delayed(const Duration(milliseconds: 300));
    await PrefService.setRole("buyer");
    Get.offAllNamed(Routes.BUYER_HOME);
  }
}