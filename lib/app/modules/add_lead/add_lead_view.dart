import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_lead_controller.dart';

class AddLeadView extends GetView<AddLeadController> {
  const AddLeadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: Get.back,
                    ),
                    Text(
                      "Add New Lead",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Scrap Type"),

                  SizedBox(height: 10),

                  Obx(
                    () => Wrap(
                      spacing: 8,
                      children: controller.scrapTypes.map((e) {
                        final selected = controller.selectedScrap.value == e;

                        return ChoiceChip(
                          label: Text(e),
                          selected: selected,
                          onSelected: (_) => controller.selectScrap(e),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 20),

                  buildField(
                    "Quantity (KG)",
                    controller: controller.qtyController,
                  ),

                  buildField(
                    "Expected Price",
                    controller: controller.priceController,
                  ),

                  buildField(
                    "Description",
                    maxLines: 3,
                    controller: controller.descController,
                  ),


                  buildField(
                    "Address",
                    maxLines: 3,
                    controller: controller.addressController,
                  ),

                  buildField("City", controller: controller.cityController),

                  buildField("Pincode", controller: controller.pinController),

                  SizedBox(height: 20),

                  Text("Upload Photo"),

                  SizedBox(height: 10),

                  Obx(
                    () => GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade400),
                          color: Colors.grey.shade100,
                        ),
                        child: controller.imageFile.value == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text("Tap to add photo"),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  controller.imageFile.value!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      print("BUTTON TAP");
                      controller.postLead();
                    },
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green.shade400, Color(0xff278DC6)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          "Post Lead",
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
          ],
        ),
      ),
    );
  }

  Widget buildField(
    String hint, {
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
