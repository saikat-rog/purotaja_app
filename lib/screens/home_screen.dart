import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/utils/auth_service.dart';

import '../utils/internal_permissions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService authService = AuthService();
  final InternalPermissions internalPermissions = InternalPermissions();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      internalPermissions.checkLocationPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                authService.setAuthenticationStatus(false);
                Get.offNamed('/auth');
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
