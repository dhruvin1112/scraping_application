import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lead_detail_controller.dart';

class LeadDetailView extends GetView<LeadDetailController> {
  const LeadDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lead = controller.lead;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                _buildImageSection(lead['imageUrl']),
                _buildCustomAppBar(lead['scrapType'] ?? "Lead Details"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildMainInfoCard(lead),
                  const SizedBox(height: 20),
                  _buildContactCard(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(String? imageUrl) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              )
            : const Center(
                child: Icon(Icons.inventory_2, size: 80, color: Colors.grey),
              ),
      ),
    );
  }

  Widget _buildCustomAppBar(String title) {
    return Positioned(
      top: 50,
      left: 10,
      right: 10,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.3),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainInfoCard(Map<String, dynamic> lead) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lead['scrapType'] ?? "Scrap Item",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            lead['description'] ??
                "High quality material available for immediate pickup. Clean and sorted as per industrial standards.",
            style: TextStyle(color: Colors.grey.shade600, height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildInfoBox(
                Icons.shopping_bag_outlined,
                "Quantity",
                "${lead['quantity']} KG",
              ),
              const SizedBox(width: 15),
              _buildInfoBox(
                Icons.currency_rupee,
                "Price",
                "₹${lead['price']}/KG",
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildLocationTile(lead['city'] ?? "Unknown Location"),
          const SizedBox(height: 15),
          Text(
            "Posted on ${lead['postDate'] ?? 'Feb 14, 2026'}",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTile(String city) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Color(0xff278DC6)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Industrial Area, $city\nGujarat, India",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          const Text(
            "Seller Contact",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey.shade50,
            child: Icon(
              Icons.lock_outline,
              size: 35,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Contact info is hidden",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            "Subscribe to view seller details",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () => controller.subscribeNow(),
              icon: const Icon(Icons.workspace_premium, color: Colors.white),
              label: const Text(
                "Subscribe Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff278DC6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
