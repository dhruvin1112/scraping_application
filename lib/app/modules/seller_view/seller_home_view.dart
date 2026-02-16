import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'seller_home_controller.dart';
import '../../routes/app_routes.dart';

class SellerHomeView extends GetView<SellerHomeController> {
  SellerHomeView({super.key});

  TextStyle tt = TextStyle(
    fontSize: 20,
    color: Colors.white.withValues(alpha: 0.8),
  );

  String timeAgo(String isoDate) {
    final dt = DateTime.parse(isoDate);
    final diff = DateTime.now().difference(dt);

    if (diff.inSeconds < 60) {
      return "${diff.inSeconds} sec ago";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else {
      return "${diff.inDays} days ago";
    }
  }

  Widget dashboardCard({
    required String imagePath,
    required String count,
    required String title,
    required List<Color> gradientColors,
  }) {
    return Container(
      height: 130,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: AlignmentDirectional(0, -2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              color: Colors.white.withValues(alpha: 0.4),
              height: 25,
              width: 25,
            ),

            SizedBox(height: 6),

            Text(
              count,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: "PlusJakartaSans",
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 4),

            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget actionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 50),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 20, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget leadCard({required Map<String, dynamic> data}) {

    final ago = timeAgo(data["createdAt"]);

    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.LEAD_DETAIL,
          arguments: {
            ...data,
            "currentUserId": controller.currentUserId,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    data["scrapType"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "${data["quantity"]} KG · ${data["city"]}",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  SizedBox(height: 4),

                  Text(
                    ago,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),

            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, Color(0xff278DC6)],
                  begin: AlignmentDirectional(0, -2),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                          "Hello, ${controller.userName.value}",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "PlusJakartaSans",
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        SizedBox(height: 4),
                        Text(
                          "Seller Dashboard",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "PlusJakartaSans",
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),


                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.recycling_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => dashboardCard(
                      imagePath: "assets/images/box.png",
                      count: controller.activeLeadCount.toString(),
                      title: "Active Leads",
                      gradientColors: [
                        Colors.green.shade300,
                        Color(0xff278DC6),
                      ],
                    ),
                  ),

                  Obx(() => dashboardCard(
                    imagePath: "assets/images/trend.png",
                    count: controller.totalViews.value.toString(),
                    title: "Total View",
                    gradientColors: [Colors.blue, Colors.blue],
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 330),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  actionCard(
                    icon: Icons.add_circle_outline_outlined,
                    iconColor: Colors.green,
                    title: "Add Lead",
                    onTap: () async {
                      final res = await Get.toNamed(Routes.ADD_LEAD);
                      if (res == true) {
                        controller.refreshLeads();
                      }
                    },
                  ),
                  actionCard(
                    icon: Icons.list_alt_outlined,
                    iconColor: Colors.blue,
                    title: "My Leads",
                    onTap: () {
                      Get.toNamed(Routes.MY_LEADS);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 480, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Leads",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.MY_LEADS);
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 530),
              child: Obx(
                () => Column(
                  children: controller.recentActiveLeads.map((e) {
                    final ago = timeAgo(e["createdAt"]);

                    return leadCard(data: e);
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 700),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        onTap: (index) async {
          switch (index) {
            case 0:
              break;

            case 1:
              final res = await Get.toNamed(Routes.ADD_LEAD);
              if (res == true) {
                controller.refreshLeads();
              }
              break;

            case 2:
              Get.toNamed(Routes.MY_LEADS);
              break;

            case 3:
              Get.toNamed(Routes.NOTIFICATIONS);
              break;

            case 4:
              Get.toNamed(Routes.PROFILE, arguments: "Seller");
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Add Lead",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: "My Leads",
          ),
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
