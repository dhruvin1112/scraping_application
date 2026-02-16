import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapeapplication/app/services/pref_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();

  String initialRoute;

  if (PrefService.isLogin()) {
    final role = PrefService.getRole();
    if (role == "seller") {
      initialRoute = Routes.SELLER_HOME;
    } else if (role == "buyer") {
      initialRoute = Routes.BUYER_HOME;
    } else {
      initialRoute = Routes.ROLE;
    }
  } else {
    initialRoute = Routes.LOGIN;
  }

  runApp(
    GetMaterialApp(
      theme: ThemeData(fontFamily: "PlusJakartaSans"),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
    ),
  );
}