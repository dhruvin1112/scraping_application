import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';

class LeadDetailController extends GetxController {

  final Map<String, dynamic> lead = Get.arguments;

  int currentUserId = 0;
  String currentUserName = "";
  String currentUserMobile = "";

  bool isSeller = false;

  @override
  void onInit() {
    super.onInit();

    currentUserId = PrefService.getUserId();
    currentUserName = PrefService.getName();
    currentUserMobile = PrefService.getMobile();

    print("Lead userId: ${lead["userId"]}");
    print("Current userId: $currentUserId");
    print("Buyer Mobile Before Insert: $currentUserMobile");

    isSeller = PrefService.getRole() == "seller";


  }


  void showSellerInfo() async {
    if (isSeller) return;

    bool alreadyViewed = await DbHelper()
        .isAlreadyViewed(lead["id"], currentUserId);

    if (!alreadyViewed) {
      await DbHelper().insertLeadView({
        "leadId": lead["id"],
        "sellerId": lead["userId"],
        "buyerId": currentUserId,
        "buyerName": currentUserName,
        "buyerMobile": currentUserMobile,
        "viewedAt": TimeOfDay.now().format(Get.context!),
      });
    }


    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFBDBDBD),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Seller Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            infoTile("Name", lead["sellerName"] ?? "-"),
            mobileTile("Mobile", lead["sellerMobile"] ?? "-"),
            infoTile("Location", lead["sellerLocation"] ?? "-"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  Widget mobileTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 15),
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.green),
                  onPressed: () {
                    makePhoneCall(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
