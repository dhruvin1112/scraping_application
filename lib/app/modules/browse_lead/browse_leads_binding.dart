import 'package:get/get.dart';
import 'browse_leads_controller.dart';

class BrowseLeadsBinding extends Bindings {
  @override
  void dependencies() {
        Get.lazyPut<BrowseLeadsController>(
          () => BrowseLeadsController(),
    );
  }
}