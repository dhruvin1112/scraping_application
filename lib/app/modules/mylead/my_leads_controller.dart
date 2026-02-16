import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';
import '../seller_view/seller_home_controller.dart';

class MyLeadsController extends GetxController {
  final DbHelper db = DbHelper();

  var leads = <Map<String, dynamic>>[].obs;
  var filter = "all".obs;

  @override
  void onInit() {
    super.onInit();
    loadLeads();
  }

  Future<void> loadLeads() async {
    int userId = PrefService.getUserId();
    leads.value = await db.getLeadsByUser(userId);
  }


  bool isActive(Map<String, dynamic> e) {
    final created = DateTime.parse(e["createdAt"]);
    final diffDays = DateTime.now().difference(created).inDays;
    return diffDays < 7;
  }

  void changeFilter(String f) {
    filter.value = f;
  }

  List<Map<String, dynamic>> get filteredLeads {
    if (filter.value == "active") {
      return leads.where((e) => isActive(e)).toList();
    }

    if (filter.value == "expired") {
      return leads.where((e) => !isActive(e)).toList();
    }

    return leads;
  }

  Future<void> deleteLead(int id) async {
    await db.deleteLead(id);
    leads.removeWhere((e) => e["id"] == id);

    final sellerController = Get.find<SellerHomeController>();
    sellerController.deleteLead({"id": id});

    Get.snackbar("Deleted", "Lead deleted successfully");
  }


  void editLead(Map<String, dynamic> e) {
    TextEditingController quantityController =
    TextEditingController(text: e["quantity"]);
    TextEditingController priceController =
    TextEditingController(text: e["price"]);

    Get.defaultDialog(
      title: "Edit Lead",
      content: Column(
        children: [
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Quantity (KG)"),
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Price (₹/KG)"),
          ),
        ],
      ),
      textConfirm: "Update",
      textCancel: "Cancel",
      onConfirm: () async {
        final updatedLead = {
          ...e,
          "quantity": quantityController.text,
          "price": priceController.text,
        };

        await db.updateLead(e["id"], {
          "quantity": quantityController.text,
          "price": priceController.text,
        });


        int index = leads.indexWhere((l) => l["id"] == e["id"]);
        if (index != -1) leads[index] = updatedLead;


        final sellerController = Get.find<SellerHomeController>();
        sellerController.editLead(updatedLead);

        Get.back();
        Get.snackbar("Updated", "Lead updated successfully");
      },
    );
  }
}
