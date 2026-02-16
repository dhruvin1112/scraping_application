import 'package:get/get.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';

class SellerHomeController extends GetxController {
  final DbHelper db = DbHelper();

  var leads = <Map<String, dynamic>>[].obs;
  var userName = ''.obs;
  int currentUserId = 0;

  var totalViews = 0.obs;


  @override
  void onInit() {
    super.onInit();
    loadUser();
    refreshLeads();
    currentUserId = PrefService.getUserId() ?? 0;
  }

  Future<void> loadUser() async {
    int userId = PrefService.getUserId();
    final user = await db.getUserById(userId);
    if (user != null) {
      userName.value = user['name'] ?? '';
    }
  }

  Future<void> refreshLeads() async {
    int userId = PrefService.getUserId();

    leads.value = await db.getLeadsByUser(userId);

    totalViews.value = await db.getTotalViewsBySeller(userId);
  }


  bool isActive(Map<String, dynamic> e) {
    if (e["createdAt"] == null) return false;
    final date = DateTime.parse(e["createdAt"]);
    return DateTime.now().difference(date).inDays < 7;
  }

  int get activeLeadCount {
    return leads.where((e) => isActive(e)).length;
  }

  List<Map<String, dynamic>> get recentActiveLeads {
    return leads.where((e) => isActive(e)).take(4).toList();
  }

  Future<void> deleteLead(Map<String, dynamic> e) async {
    try {
      await db.deleteLead(e["id"]);
      leads.removeWhere((l) => l["id"] == e["id"]);
      leads.refresh();
      Get.snackbar("Deleted", "Lead deleted successfully");
    } catch (err) {
      Get.snackbar("Error", "Failed to delete lead");
    }
  }

  Future<void> editLead(Map<String, dynamic> updatedLead) async {
    try {
      await db.updateLead(updatedLead["id"], {
        "quantity": updatedLead["quantity"],
        "price": updatedLead["price"],
      });

      int index = leads.indexWhere((l) => l["id"] == updatedLead["id"]);
      if (index != -1) leads[index] = updatedLead;

      leads.refresh();

      Get.snackbar("Updated", "Lead updated successfully");
    } catch (err) {
      Get.snackbar("Error", "Failed to update lead");
    }
  }
}
