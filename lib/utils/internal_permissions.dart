import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:purotaja/utils/toast_message.dart';

class InternalPermissions {

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      // Redirect to a different page for location permission
      Get.toNamed('/askLocation');
    } else if (status.isGranted) {
      if (kDebugMode) {
        print('Location permission granted');
      }
    }
  }

  Future<void> askLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      Get.back();
      showToast('Location granted.');
      if (kDebugMode) {
        print('Location permission granted');
      }
    }
    else{
      showToast('Location denied. We need your location.');
    }
  }
}
