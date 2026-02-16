import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {

  void hello(){

    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(Routes.LOGIN);
    });
    print("onRady()=======================");
  }

}
