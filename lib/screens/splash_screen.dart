import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:purotaja/services/auth_service.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Future.delayed(const Duration(seconds: 2),() async {
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
              height: screenWidth*0.32,
              fit: BoxFit.cover,
            ),
          ),
          // Positioned image in the top-left corner
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/ellipse_1005.svg',
              height: screenWidth*0.32,
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
                  height: screenWidth*0.3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
