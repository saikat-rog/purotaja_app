import 'package:get/get.dart';

class NavigationController extends GetxController {
  // Track selected index
  var selectedIndex = 0.obs;

  // Method to change the screen based on nav item click
  void onNavBarItemTapped(int index) {
    selectedIndex.value = index;
  }
}
