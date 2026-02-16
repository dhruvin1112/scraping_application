import 'package:get/get.dart';
import 'lead_detail_controller.dart';

class LeadDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeadDetailController());
  }
}
