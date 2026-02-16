import 'package:get/get.dart';
import 'seller_home_controller.dart';

class SellerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SellerHomeController());
  }
}
