import 'package:get/get.dart';

class NotificationsController extends GetxController {

  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = [
      {
        "title": "New Iron Scrap Lead",
        "message": "500 KG iron scrap available in Mumbai",
        "time": DateTime.now().subtract(Duration(minutes: 2)).toIso8601String(),
        "unread": true,
        "type": "lead"
      },
      {
        "title": "Subscription Reminder",
        "message": "Your plan expires in 7 days. Renew now!",
        "time": DateTime.now().subtract(Duration(hours: 1)).toIso8601String(),
        "unread": true,
        "type": "plan"
      },
      {
        "title": "New Copper Lead",
        "message": "50 KG copper wire available in Pune",
        "time": DateTime.now().subtract(Duration(hours: 3)).toIso8601String(),
        "unread": false,
        "type": "lead"
      },
      {
        "title": "New Plastic Lead",
        "message": "200 KG plastic waste available in Delhi",
        "time": DateTime.now().subtract(Duration(hours: 5)).toIso8601String(),
        "unread": false,
        "type": "lead"
      },
      {
        "title": "Payment Received",
        "message": "Your Professional plan payment of ₹4,999 was successful",
        "time": DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
        "unread": false,
        "type": "plan"
      },
    ];
  }

  String timeAgo(String iso) {
    final dt = DateTime.parse(iso);
    final diff = DateTime.now().difference(dt);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} mins ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hrs ago";
    } else {
      return "${diff.inDays} day ago";
    }
  }

  void markRead(int index) {
    notifications[index]["unread"] = false;
    notifications.refresh();
  }
}
