import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'buyer_home_controller.dart';
import '../../routes/app_routes.dart';

class BuyerHomeView extends GetView<BuyerHomeController> {
  const BuyerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchDashboardStats(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              _buildHeaderSection(),
              Padding(
                padding: const EdgeInsets.only(top: 310, left: 20, right: 20),
                child: Column(
                  children: [
                    _buildCategoriesAndStats(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              _buildPremiumCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade300, const Color(0xff278DC6)],
          begin: const AlignmentDirectional(0, -2),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                    "Hello, ${controller.userName.value.isEmpty ? 'Buyer' : controller.userName.value}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  const Text(
                    "Buyer Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.recycling, color: Colors.white, size: 35),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.BROWSE_LEADS),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.white60),
                  SizedBox(width: 10),
                  Text(
                    "Search leads by type, city...",
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesAndStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Browse by Category",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final item = controller.categories[index];
            return GestureDetector(
              onTap: () =>
                  Get.toNamed(Routes.BROWSE_LEADS, arguments: item['name']),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item['icon']!, style: const TextStyle(fontSize: 28)),
                    const SizedBox(height: 8),
                    Text(
                      item['name']!,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 25),
        Obx(
          () => Row(
            children: [
              _buildStatBox(
                controller.totalActiveLeads.value.toString(),
                "Active Leads",
                Icons.inventory_2_outlined,
                Colors.green,
                onTap: () => Get.toNamed(Routes.BROWSE_LEADS),
              ),
              const SizedBox(width: 15),
              _buildStatBox(
                controller.newLeadsToday.value.toString(),
                "New Today",
                Icons.trending_up,
                Colors.blue,
                onTap: () => Get.toNamed(Routes.BROWSE_LEADS),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox(
    String val,
    String label,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 10),
              Text(
                val,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumCard() {
    return Positioned(
      top: 210,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          children: [
            const Icon(Icons.workspace_premium, color: Colors.orange, size: 35),
            const SizedBox(width: 15),
            const Expanded(
              child: Text(
                "Upgrade to Premium\nGet seller contacts",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: (index) {
          controller.changeTabIndex(index);
          if (index == 1)
            Get.toNamed(
              Routes.BROWSE_LEADS,
            )?.then((_) => controller.fetchDashboardStats());
          if (index == 3) Get.toNamed(Routes.PROFILE, arguments: "Buyer");
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E9B7E),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Leads"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: "Alerts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
