import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  InputDecoration fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.green, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Change Password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Obx(() => TextField(
                    controller: controller.oldPass,
                    obscureText: controller.hideOld.value,
                    decoration: fieldDecoration("Old Password").copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.hideOld.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.toggleOld,
                      ),
                    ),
                  )),
                  const SizedBox(height: 18),
                  Obx(() => TextField(
                    controller: controller.newPass,
                    obscureText: controller.hideNew.value,
                    decoration: fieldDecoration("New Password").copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.hideNew.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.toggleNew,
                      ),
                    ),
                  )),
                  const SizedBox(height: 18),
                  Obx(() => TextField(
                    controller: controller.confirmPass,
                    obscureText: controller.hideConfirm.value,
                    decoration: fieldDecoration("Confirm Password").copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.hideConfirm.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.toggleConfirm,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.teal],
                ),
              ),
              child: ElevatedButton(
                onPressed: controller.change,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Update Password",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
