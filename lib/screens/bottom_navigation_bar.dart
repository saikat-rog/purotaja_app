import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/screens/account_screen/account_screen.dart';
import 'package:purotaja/screens/category_screen/category_screen.dart';
import 'package:purotaja/screens/home_screen/home_screen.dart';
import '../controllers/navigation_controller.dart';
import '../screens/orders_screen/orders_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final NavigationController navigationController = Get.put(NavigationController());

    return Scaffold(
      body: Obx(
            () {
          // Show the current screen based on the selected index
          switch (navigationController.selectedIndex.value) {
            case 0:
              return const HomeScreen();
            case 1:
              return CategoryScreen();
            case 2:
              return OrdersScreen();
            case 3:
              return AccountScreen();
            default:
              return HomeScreen();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationController.selectedIndex.value,
        onTap: navigationController.onNavBarItemTapped,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/home.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/category.png'),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/orders.png'),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/profile.png'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
