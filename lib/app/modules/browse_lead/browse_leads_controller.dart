import 'package:get/get.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';

class BrowseLeadsController extends GetxController {
  final DbHelper db = DbHelper();
  var allLeads = <Map<String, dynamic>>[].obs;
  var filteredLeads = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var showFilters = false.obs;
  var selectedCategory = "All".obs;

  int currentUserId = 0;
  String currentUserName = "";
  String currentUserMobile = "";


  final List<String> categories = [
    "All", "Iron", "Plastic", "Copper", "Paper", "Metal", "E-Waste"
  ];

  @override
  void onInit() {
    super.onInit();
    String? arg = Get.arguments as String?;
    if (arg != null) {
      selectedCategory.value = arg;
    }
    fetchAllLeads();
    currentUserId = PrefService.getUserId();
    currentUserName = PrefService.getName();
    currentUserMobile = PrefService.getMobile();

  }

  Future<void> fetchAllLeads() async {
    try {
      isLoading(true);
      final leads = await db.getLeads();
      DateTime now = DateTime.now();

      var activeLeads = leads.where((lead) {
        if (lead['createdAt'] == null) return false;
        DateTime createdAt = DateTime.parse(lead['createdAt']);
        return now.difference(createdAt).inDays <= 7;
      }).toList();

      allLeads.assignAll(activeLeads);
      applyCategoryFilter(selectedCategory.value);
    } finally {
      isLoading(false);
    }
  }

  void toggleFilterSection() {
    showFilters.value = !showFilters.value;
  }

  void applyCategoryFilter(String category) {
    selectedCategory.value = category;
    if (category == "All") {
      filteredLeads.assignAll(allLeads);
    } else {
      var results = allLeads.where((lead) {
        return lead['scrapType'].toString().toLowerCase() == category.toLowerCase();
      }).toList();
      filteredLeads.assignAll(results);
    }
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      applyCategoryFilter(selectedCategory.value);
    } else {
      var results = allLeads.where((lead) {
        final scrapType = lead['scrapType'].toString().toLowerCase();
        final city = lead['city'].toString().toLowerCase();
        final searchLower = query.toLowerCase();
        return scrapType.contains(searchLower) || city.contains(searchLower);
      }).toList();
      filteredLeads.assignAll(results);
    }
  }
}