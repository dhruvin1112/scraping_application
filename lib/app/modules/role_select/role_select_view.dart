import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'role_select_controller.dart';

class RoleSelectView extends GetView<RoleSelectController> {
  const RoleSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.green.shade300, const Color(0xff278DC6)],
                    begin: AlignmentDirectional(0, -1),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: const Icon(
                          Icons.recycling,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const Text(
                      "Choose Your Role",
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: "PlusJakartaSans",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        "How would you like to use ScrapLeads?",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PlusJakartaSans",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 370, left: 25, right: 25),
                child: Obx(
                  () => InkWell(
                    onTap: controller.selectSeller,
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(
                          color: controller.selectedRole.value == 1
                              ? const Color(0xff278DC6)
                              : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _buildRoleContent(
                        imagePath: "assets/images/box.png",
                        title: "I'm a Seller",
                        subtitle: "Post scrap leads for buyers to find",
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 530, left: 25, right: 25),
                child: Obx(
                  () => InkWell(
                    onTap: controller.selectBuyer,
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(
                          color: controller.selectedRole.value == 2
                              ? const Color(0xff278DC6)
                              : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _buildRoleContent(
                        imagePath: "assets/images/cart.png",
                        title: "I'm a Buyer",
                        subtitle: "Browse scrap leads with subscription",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleContent({
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Container(
          padding: const EdgeInsets.all(15),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.green.shade300, const Color(0xff278DC6)],
              begin: AlignmentDirectional(0, -1),
            ),
          ),
          child: Image.asset(
            imagePath,
            color: Colors.white,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.4),
                  fontFamily: "PlusJakartaSans",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
