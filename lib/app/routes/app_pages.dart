import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/add_lead/add_lead_binding.dart';
import '../modules/add_lead/add_lead_view.dart';
import '../modules/address/address_binding.dart';
import '../modules/address/address_view.dart';
import '../modules/auth/login/login_binding.dart';
import '../modules/auth/login/login_view.dart';
import '../modules/auth/signup/signup_binding.dart';
import '../modules/auth/signup/signup_view.dart';
import '../modules/browse_lead/browse_leads_binding.dart';
import '../modules/browse_lead/browse_leads_view.dart';
import '../modules/buyer_view/buyer_home_binding.dart';
import '../modules/buyer_view/buyer_home_view.dart';
import '../modules/change_password/change_password_binding.dart';
import '../modules/change_password/change_password_view.dart';
import '../modules/lead_detail/lead_detail_binding.dart';
import '../modules/lead_detail/lead_detail_view.dart';
import '../modules/mylead/my_leads_binding.dart';
import '../modules/mylead/my_leads_view.dart';
import '../modules/notification/notifications_binding.dart';
import '../modules/notification/notifications_view.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_view.dart';
import '../modules/role_select/role_select_binding.dart';
import '../modules/role_select/role_select_view.dart';
import '../modules/seller_view/seller_home_binding.dart';
import '../modules/seller_view/seller_home_view.dart';
import '../modules/splash/splash_view.dart';
import '../modules/splash/splash_binding.dart';
import 'app_routes.dart';
import '../modules/edit_profile/edit_profile_binding.dart';
import '../modules/edit_profile/edit_profile_view.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignUpView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: Routes.ROLE,
      page: () => const RoleSelectView(),
      binding: RoleSelectBinding(),
    ),
    GetPage(
      name: Routes.SELLER_HOME,
      page: () => SellerHomeView(),
      binding: SellerHomeBinding(),
    ),
    GetPage(
      name: Routes.BUYER_HOME,
      page: () => const BuyerHomeView(),
      binding: BuyerHomeBinding(),
    ),
    GetPage(
      name: Routes.ADD_LEAD,
      page: () => const AddLeadView(),
      binding: AddLeadBinding(),
    ),
    GetPage(
      name: Routes.MY_LEADS,
      page: () => const MyLeadsView(),
      binding: MyLeadsBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: Routes.LEAD_DETAIL,
      page: () => const LeadDetailView(),
      binding: LeadDetailBinding(),
    ),
    GetPage(
      name: Routes.ADDRESS,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.BROWSE_LEADS,
      page: () => const BrowseLeadsView(),
      binding: BrowseLeadsBinding(),
    ),

    GetPage(
      name: Routes.LEAD_DETAIL,
      page: () => const LeadDetailView(),
      binding: LeadDetailBinding(),
    ),
  ];
}