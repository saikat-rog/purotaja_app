import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:purotaja/screens/account_screen/account_screen.dart';
import 'package:purotaja/screens/category_screen/category_screen.dart';
import 'package:purotaja/screens/home_screen/home_screen.dart';
import 'package:purotaja/widgets/view_cart.dart';
import '../app_theme.dart';
import '../controllers/cart_controller.dart';
import '../controllers/navigation_controller.dart';
import '../screens/orders_screen/orders_screen.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

    final NavigationController navigationController =
        Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    navigationController.selectedIndex.value = Get.arguments ?? 0;
    final CartController cartController = Get.put(CartController());
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => cartController.cartItems.isNotEmpty &&
                    navigationController.selectedIndex.value != 3
                ? ViewCartWidget()
                : const SizedBox.shrink(),
          ),
          Obx(
                () => SizedBox(
              height: 70, // Set the desired height for the BottomNavigationBar
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: navigationController.selectedIndex.value,
                onTap: (index) {
                  navigationController.onNavBarItemTapped(index);
                },
                backgroundColor: Colors.white,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, // Optional: Make the text bold
                ),
                unselectedLabelStyle: const TextStyle(
                  decoration: TextDecoration.none, // No underline for unselected labels
                ),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/home.svg', height: 20), // Adjust icon size if needed
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/category.svg', height: 20),
                    label: 'Category',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/orders.svg', height: 20),
                    label: 'Orders',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/profile.svg', height: 20),
                    label: 'Profile',
                  ),
                ]
              ),
            ),
          ),

        ],
      ),
    );
  }
}
