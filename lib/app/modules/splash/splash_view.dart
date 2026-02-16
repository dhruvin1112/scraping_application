import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.hello();
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset("assets/images/splash.png", fit: BoxFit.fill),
      ),
    );
  }
}
