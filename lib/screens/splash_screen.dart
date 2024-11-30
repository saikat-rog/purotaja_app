import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:purotaja/utils/auth_service.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),() async {
      final isAuthenticated = AuthService().getAuthenticationStatus();
      await isAuthenticated ? Get.offNamed('/') : Get.offNamed('/onboarding');
    });
    return Scaffold(
      body: Stack(
        children: [
          //Eclipses in the corner
          // Positioned image in the bottom-right corner
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/ellipse_1006.svg',
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          // Positioned image in the top-left corner
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/ellipse_1005.svg',
              height: 150,
              fit: BoxFit.cover,
            ),
          ),

          // Logo in the center
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/purotaja_logo.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
