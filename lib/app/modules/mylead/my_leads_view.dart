import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/db_helper.dart';
import 'my_leads_controller.dart';

class MyLeadsView extends GetView<MyLeadsController> {
  const MyLeadsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.blue],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  Text(
                    "My Leads",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tab("All", "all"),
              _tab("Active", "active"),
              _tab("Expired", "expired"),
            ],
          )),

          const SizedBox(height: 12),

          Expanded(
            child: Obx(() {
              final list = controller.filteredLeads;

              if (list.isEmpty) {
                return Center(child: Text("No Leads"));
              }

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) {
                  final e = list[i];
                  final active = controller.isActive(e);
                  return _leadCard(e, active);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _tab(String title, String key) {
    final c = Get.find<MyLeadsController>();
    final selected = c.filter.value == key;

    return GestureDetector(
      onTap: () => c.changeFilter(key),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _leadCard(Map<String, dynamic> e, bool active) {
    final dt = DateTime.parse(e["createdAt"]);
    final dateOnly = "${dt.day}-${dt.month}-${dt.year}";

    return FutureBuilder(
      future: DbHelper().getLeadViewsByLeadId(e["id"]),
      builder: (context, snapshot) {

        List<Map<String, dynamic>> buyers = [];

        if (snapshot.hasData) {
          buyers = snapshot.data as List<Map<String, dynamic>>;
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Text(
                    e["scrapType"],
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  _statusChip(active),
                  Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      final controller = Get.find<MyLeadsController>();
                      if (value == "edit") {
                        controller.editLead(e);
                      } else if (value == "delete") {
                        controller.deleteLead(e["id"]);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "edit",
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 8),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: Row(
                          children: [
                            Icon(Icons.delete,
                                size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text("Delete"),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 6),

              Text("${e["quantity"]} KG · ₹${e["price"]}/KG"),
              Text("${e["city"]} - ${e["pincode"]}"),
              Text(dateOnly),

              SizedBox(height: 10),

              buyers.isEmpty
                  ? Text(
                "No buyer contacted yet",
                style: TextStyle(color: Colors.grey),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buyers.map((b) {
                  return Container(
                    margin: EdgeInsets.only(top: 6),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Buyer: ${b["buyerName"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text("Mobile: ${b["buyerMobile"]}"),
                        Text(
                          "Viewed: ${b["viewedAt"]}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusChip(bool active) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: active ? Colors.green.shade100 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        active ? "active" : "expired",
        style: TextStyle(
          fontSize: 12,
          color: active ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}
