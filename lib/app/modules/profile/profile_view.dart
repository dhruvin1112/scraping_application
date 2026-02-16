import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, const Color(0xff278DC6)],
                  begin: Alignment.topCenter,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 28),
                        onPressed: Get.back,
                      ),
                      const Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: const Icon(Icons.person,
                            size: 50, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Obx(
                              () => Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.name.value,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.role.value,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -30),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        infoRow(Icons.email, "Email",
                            controller.email),
                        infoRow(Icons.phone, "Phone",
                            controller.phone),
                        infoRow(Icons.location_on, "Location",
                            controller.location),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            menuTile(Icons.person_outline, "Edit Profile",
                    () => Get.toNamed('/edit-profile')),
            menuTile(Icons.lock_outline, "Change Password",
                    () => Get.toNamed('/change-password')),
            menuTile(Icons.location_on_outlined,
                "Manage Address", () => Get.toNamed('/address')),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                onPressed: controller.logout,
                icon: const Icon(Icons.logout,
                    color: Colors.red),
                label: const Text("Logout",
                    style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  minimumSize:
                  const Size(double.infinity, 55),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget infoRow(
      IconData icon, String label, RxString value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(
                  () => Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey)),
                  Text(
                    value.value,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight:
                        FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuTile(
      IconData icon, String title, VoidCallback tap) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(14)),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16),
          onTap: tap,
        ),
      ),
    );
  }
}
