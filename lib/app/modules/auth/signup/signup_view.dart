import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scrapeapplication/app/modules/auth/signup/signup_controller.dart';
import 'package:scrapeapplication/app/routes/app_routes.dart';

class SignUpView extends GetView<SignupController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // ===== HEADER =====
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, Color(0xff278DC6)],
                  begin: Alignment.topCenter, // ✅ fix
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 130, right: 300),
                    child: IconButton(
                      onPressed: () => Get.offNamed(Routes.LOGIN),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 120, top: 10),
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7), // safer
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Text(
                      "Join the scrap marketplace today",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ===== FORM =====
            Padding(
              padding: const EdgeInsets.only(top: 300, left: 25),
              child: Container(
                height: 520, // ✅ increased from 400
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    field(
                      "Enter your full name",
                      TextInputType.text,
                      controller.setName,
                    ),

                    field(
                      "Enter mobile number",
                      TextInputType.phone,
                      controller.setMobile,
                    ),

                    field(
                      "Enter email",
                      TextInputType.emailAddress,
                      controller.setEmail,
                    ),

                    field(
                      "Enter location",
                      TextInputType.text,
                      controller.setLocation,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Obx(
                        () => TextField(
                          obscureText: controller.hidePassword.value,
                          onChanged: controller.setPassword,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16),
                          ],
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
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
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: controller.signup,
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade300,
                                Color(0xff278DC6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Send OTP",
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
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
              padding: const EdgeInsets.only(top: 820),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withValues(alpha: 0.4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.offNamed(Routes.LOGIN),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 25, color: Colors.green,fontWeight: FontWeight.bold),
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

  Widget field(String hint, TextInputType type, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        keyboardType: type,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
