import 'package:get/get.dart';
import 'my_leads_controller.dart';

class MyLeadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyLeadsController>(() => MyLeadsController());
  }
}
