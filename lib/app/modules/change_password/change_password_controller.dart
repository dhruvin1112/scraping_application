import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';

class ChangePasswordController extends GetxController {
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();
  final db = DbHelper();

  var hideOld = true.obs;
  var hideNew = true.obs;
  var hideConfirm = true.obs;

  void toggleOld() => hideOld.value = !hideOld.value;
  void toggleNew() => hideNew.value = !hideNew.value;
  void toggleConfirm() => hideConfirm.value = !hideConfirm.value;

  Future<void> change() async {
    final id = PrefService.getUserId();
    if (id == 0) return;

    final user = await db.getUserById(id);
    if (user == null) {
      Get.snackbar("Error", "User not found");
      return;
    }

    if (user["password"] != oldPass.text.trim()) {
      Get.snackbar("Error", "Old password is wrong");
      return;
    }

    if (newPass.text.trim().length < 6) {
      Get.snackbar("Error", "New password must be 6+ chars");
      return;
    }

    if (newPass.text.trim() != confirmPass.text.trim()) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    final result = await db.updateProfile(id, {
      "password": newPass.text.trim(),
    });

    if (result > 0) {
      oldPass.clear();
      newPass.clear();
      confirmPass.clear();

      Get.snackbar("Success", "Password updated");

      await Future.delayed(const Duration(milliseconds: 500));
      Get.back();
    } else {
      Get.snackbar("Error", "Password not updated");
    }
  }
}
