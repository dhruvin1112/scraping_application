import 'package:get/get.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';

class BuyerHomeController extends GetxController {
  final DbHelper db = DbHelper();

  var userName = "".obs;
  var totalActiveLeads = 0.obs;
  var newLeadsToday = 0.obs;
  var selectedIndex = 0.obs;
  var isLoading = false.obs;

  final List<Map<String, String>> categories = [
    {'name': 'Iron', 'icon': '⚙️'},
    {'name': 'Plastic', 'icon': '♻️'},
    {'name': 'Copper', 'icon': '🔌'},
    {'name': 'Paper', 'icon': '📄'},
    {'name': 'Metal', 'icon': '🏗️'},
    {'name': 'E-Waste', 'icon': '💻'},
  ];

  @override
  void onReady() {
    super.onReady();
    refreshUserData();
    fetchDashboardStats();
  }

  Future<void> refreshUserData() async {
    try {
      String localName = PrefService.getName();
      if (localName.isNotEmpty) userName.value = localName;

      int id = PrefService.getUserId();
      if (id != 0) {
        var user = await db.getUserById(id);
        if (user != null && user['name'] != null) {
          userName.value = user['name'].toString();
          await PrefService.setName(userName.value);
        }
      }
    } catch (e) {
      print("User Data Error: $e");
    }
  }

  Future<void> fetchDashboardStats() async {
    try {
      isLoading.value = true;
      final leads = await db.getLeads();
      totalActiveLeads.value = leads.length;

      String today = DateTime.now().toIso8601String().split('T')[0];
      newLeadsToday.value = leads
          .where((e) => e['createdAt'].toString().contains(today))
          .length;
    } catch (e) {
      print("Stats Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void changeTabIndex(int index) => selectedIndex.value = index;
}