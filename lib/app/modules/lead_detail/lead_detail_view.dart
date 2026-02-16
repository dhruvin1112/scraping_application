import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lead_detail_controller.dart';
import 'dart:io';

class LeadDetailView extends GetView<LeadDetailController> {
  const LeadDetailView({super.key});

  Widget infoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeadDetailController>(
      builder: (controller) {
        final lead = controller.lead;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Lead Details"),
            backgroundColor: Colors.green,
          ),
          backgroundColor: Colors.grey.shade100,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (lead["imagePath"] != null && lead["imagePath"] != "")
                  Container(
                    height: 220,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: FileImage(File(lead["imagePath"])),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                infoTile("Scrap Type", lead["scrapType"] ?? ""),
                infoTile("Quantity", "${lead["quantity"]} KG"),
                infoTile("City", lead["city"] ?? ""),
                infoTile("Price", "₹ ${lead["price"] ?? "-"}"),
                infoTile("Created At", lead["createdAt"] ?? ""),
                infoTile("Description", lead["description"] ?? "-"),
                const SizedBox(height: 20),
                if (!controller.isSeller)
                  GestureDetector(
                    onTap: controller.showSellerInfo,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [Colors.green.shade400, Colors.blue],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Contact Seller",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
