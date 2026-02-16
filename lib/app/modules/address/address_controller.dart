import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';
import '../profile/profile_controller.dart';

class AddressController extends GetxController {
  final location = TextEditingController();
  final db = DbHelper();

  int userId = 0;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    userId = PrefService.getUserId() ?? 0;
    if (userId == 0) return;

    final u = await db.getUserById(userId);
    if (u != null) {
      location.text = u["location"]?.toString() ?? "";
    }
  }

  Future<void> save() async {
    if (location.text.trim().isEmpty) {
      Get.snackbar("Error", "Enter location");
      return;
    }

    await db.updateProfile(userId, {"location": location.text.trim()});

    if (Get.isRegistered<ProfileController>()) {
      await Get.find<ProfileController>().loadProfile();
    }

    Get.back();
    Get.snackbar("Saved", "Address updated");
  }

  @override
  void onClose() {
    location.dispose();
    super.onClose();
  }
}
