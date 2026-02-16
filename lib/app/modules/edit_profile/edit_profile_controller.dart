import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';

class EditProfileController extends GetxController {

  final db = DbHelper();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final location = TextEditingController();

  int userId = 0;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() async {
    userId = PrefService.getUserId();
    final u = await db.getUserById(userId);
    if (u != null) {
      name.text = u["name"];
      email.text = u["email"];
      phone.text = u["mobile"];
      location.text = u["location"];
    }
  }

  void save() async {
    await db.updateProfile(userId, {
      "name": name.text,
      "email": email.text,
      "mobile": phone.text,
      "location": location.text,
    });

    Get.back(result: true); // refresh signal
  }
}
