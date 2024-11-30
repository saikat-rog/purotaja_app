import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:purotaja/screens/access_location.dart';
import 'package:purotaja/screens/auth_screen.dart';
import 'package:purotaja/screens/cart_screen.dart';
import 'package:purotaja/screens/home_screen.dart';
import 'package:purotaja/screens/onboarding_screen.dart';
import 'package:purotaja/screens/splash_screen.dart';

class AppRoutes{
  static final List<GetPage> routes = [
    GetPage(name: '/', page: () => const HomeScreen(), transition: Transition.zoom, transitionDuration: const Duration(milliseconds: 500),),
    GetPage(name: '/splash', page: () => const SplashScreen(), transition: Transition.zoom, transitionDuration: const Duration(milliseconds: 500),),
    GetPage(name: '/onboarding', page: () => OnBoardingScreen(), transition: Transition.zoom, transitionDuration: const Duration(milliseconds: 500),),
    GetPage(name: '/cart', page: () => const CartScreen(), transition: Transition.zoom, transitionDuration: const Duration(milliseconds: 500),),
    GetPage(name: '/auth', page: () => const AuthScreen(), transition: Transition.zoom, transitionDuration: const Duration(milliseconds: 500),),
    GetPage(name: '/askLocation', page: () => const AccessLocationScreen(),transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 500),),
  ];
}