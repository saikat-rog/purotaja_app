import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:purotaja/screens/access_location_screen.dart';
import 'package:purotaja/screens/account_screen/account_options/addresses_screen/add_address_screen.dart';
import 'package:purotaja/screens/account_screen/account_options/addresses_screen/addresses_screen.dart';
import 'package:purotaja/screens/account_screen/account_options/addresses_screen/edit_addresses_acreen.dart';
import 'package:purotaja/screens/account_screen/account_options/faqs_screen.dart';
import 'package:purotaja/screens/account_screen/account_options/favourite_screen.dart';
import 'package:purotaja/screens/account_screen/account_options/notifications_screen.dart';
import 'package:purotaja/screens/account_screen/account_options/personal_info_screen.dart';
import 'package:purotaja/screens/account_screen/account_options/reviews_screen.dart';
import 'package:purotaja/screens/account_screen/account_screen.dart';
import 'package:purotaja/screens/auth_screen.dart';
import 'package:purotaja/screens/bottom_navigation_bar.dart';
import 'package:purotaja/screens/cart_screen/cart_screen.dart';
import 'package:purotaja/screens/category_screen/category_screen.dart';
import 'package:purotaja/screens/home_screen/home_screen.dart';
import 'package:purotaja/screens/onboarding_screen.dart';
import 'package:purotaja/screens/orders_screen/orders_screen.dart';
import 'package:purotaja/screens/product_info_screen.dart';
import 'package:purotaja/screens/search_screen.dart';
import 'package:purotaja/screens/splash_screen.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 900),
    ),
    GetPage(
      name: '/onboarding',
      page: () => OnBoardingScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 900),
    ),
    GetPage(
      name: '/auth',
      page: () => const AuthScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/',
      page: () => BottomNavBar(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/askLocation',
      page: () => const AccessLocationScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/category',
      page: () => CategoryScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/orders',
      page: () => OrdersScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
        name: '/account',
        page: () => const AccountScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
      name: '/personalInfo',
      page: () => const PersonalInfoScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/myOrders',
      page: () => const OrdersScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/favourite',
      page: () => const FavouriteScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/notifications',
      page: () => const NotificationsScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/faqs',
      page: () => const FAQsScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/reviews',
      page: () => const ReviewsScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/addresses',
      page: () => AddressScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/product/:productId',
      page: () => ProductInfoScreen(
        productId: Get.parameters['productId']!,
      ),
    ),
    GetPage(
      name: '/editAddress/:addressId',
      page: () => EditAddressScreen(
        addressId: Get.parameters['addressId']!,
      ),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/addAddresses',
      page: () => const AddAddressScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/search',
      page: () => SearchScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: '/cart',
      page: () => CartScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 200),
    ),
  ];
}
