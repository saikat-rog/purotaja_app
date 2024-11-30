import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import 'package:geolocator/geolocator.dart';

class UserController extends GetxController {
  // User model stored as observable
  var user = UserModel(name: '', email: '').obs;
  var userLocation = 'Finding you...'.obs;

  // Method to update user data after login
  void setUser(UserModel newUser) {
    user.value = newUser;
  }

  Future<void> setUserLocation() async {
    try {
      // Get current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // Minimum distance to trigger updates
        ),
      );

      // Get placemarks (addresses) from latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Check if we have any placemarks
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        // Set the user location as a human-readable address (e.g., city, country)
        userLocation.value = "${place.locality}, ${place.country}";
      } else {
        userLocation.value = "Location not found";
      }
    } catch (e) {
      userLocation.value = "Failed to get location";
      if (kDebugMode) {
        print('Failed to get location: $e');
      }
    }
  }
}
