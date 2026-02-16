import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';

class AddLeadController extends GetxController {
  final db = DbHelper();

  final qtyController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pinController = TextEditingController();

  var scrapTypes = [
    "Iron",
    "Plastic",
    "Glass",
    "Paper",
    "Tin",
    "Metal",
    "Copper",
    "Aluminium",
    "E-Waste",
    "Rubber"
  ].obs;

  var selectedScrap = "Iron".obs;
  var imageFile = Rx<File?>(null);

  void selectScrap(String v) => selectedScrap.value = v;

  Future pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      imageFile.value = File(img.path);
    }
  }

  Future<void> postLead() async {
    final userId = PrefService.getUserId();

    if (userId == 0) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    if (qtyController.text.isEmpty || priceController.text.isEmpty) {
      Get.snackbar("Error", "Please fill required fields");
      return;
    }

    final user = await db.getUserById(userId);

    final data = {
      "userId": userId,
      "scrapType": selectedScrap.value,
      "quantity": qtyController.text,
      "price": priceController.text,
      "description": descController.text,
      "address": addressController.text,
      "city": cityController.text,
      "pincode": pinController.text,
      "imagePath": imageFile.value?.path ?? "",
      "createdAt": DateTime.now().toString(),
      "sellerName": user?["name"] ?? "",
      "sellerMobile": user?["mobile"] ?? "",
      "sellerLocation": user?["location"] ?? "",
    };

    await db.insertLead(data);

    Get.back(result: true);
  }

  @override
  void onClose() {
    qtyController.dispose();
    priceController.dispose();
    descController.dispose();
    addressController.dispose();
    cityController.dispose();
    pinController.dispose();
    super.onClose();
  }
}
