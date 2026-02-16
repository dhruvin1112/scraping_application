import 'package:get/get.dart';
import '../../data/db_helper.dart';
import '../../services/pref_service.dart';

class LeadDetailController extends GetxController {
  final DbHelper db = DbHelper();

  late Map<String, dynamic> lead;

  @override
  void onInit() async {
    super.onInit();

    lead = Get.arguments;

    await insertWeightedView();
  }


  Future<void> insertWeightedView() async {
    int leadId = lead["id"];
    int sellerId = lead["userId"];
    int buyerId = PrefService.getUserId();


    if (buyerId == sellerId) return;


    final lastViewList = await db.getLeadViewsByLeadId(leadId);
    DateTime? lastView;

    for (var view in lastViewList.reversed) {
      if (view["buyerId"] == buyerId) {
        lastView = DateTime.parse(view["viewedAt"]);
        break;
      }
    }

    final now = DateTime.now();
    bool shouldInsert = false;

    if (lastView == null) {

      shouldInsert = true;
    } else {
      final diff = now.difference(lastView);

      if (diff.inMinutes >= 60) {

        shouldInsert = true;
      }

    }

    if (shouldInsert) {
      final buyer = await db.getUserById(buyerId);

      await db.insertLeadView({
        "leadId": leadId,
        "sellerId": sellerId,
        "buyerId": buyerId,
        "buyerName": buyer?["name"],
        "buyerMobile": buyer?["mobile"],
        "viewedAt": now.toIso8601String(),
      });
    }
  }

  void subscribeNow() {
    Get.snackbar(
      "Premium",
      "Redirecting to payment gateway...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
