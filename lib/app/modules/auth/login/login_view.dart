import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../routes/app_routes.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, Color(0xff278DC6)],
                  begin: AlignmentGeometry.directional(0, -1),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150, left: 50),
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.recycling,
                            color: Colors.white,
                            size: 40,
                          ),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        Padding(padding: EdgeInsetsGeometry.only(left: 20)),
                        Text(
                          "ScrapLeads",
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: "PlusJakartaSans",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 80, top: 30),
                    child: Text(
                      "Welcome back 👋",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PlusJakartaSans",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Text(
                      "Login to manage your scrap leads",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PlusJakartaSans",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350, left: 25),
              child: Container(
                height: 350,
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "PlusJakartaSans",
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: controller.setMobile,
                        decoration: InputDecoration(
                          hintText: "Enter mobile number",
                          hintStyle: TextStyle(
                            color: Colors.black.withValues(alpha: 0.4),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
        
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Obx(
                        () => TextField(
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "PlusJakartaSans",
                          ),
                          obscureText: controller.hidePassword.value,
                          onChanged: controller.setPassword,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16),
                          ],
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                              color: Colors.black.withValues(alpha: 0.4),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(style: BorderStyle.solid),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.hidePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: controller.togglePassword,
                            ),
                          ),
                        ),
                      ),
                    ),
        
                    Padding(
                      padding: const EdgeInsets.only(right: 220),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                      ),
                    ),
        
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: controller.login,
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green.shade300, Color(0xff278DC6)],
                              begin: AlignmentGeometry.directional(-1, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: "PlusJakartaSans",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 700),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withValues(alpha: 0.5),
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}