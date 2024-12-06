import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'package:geolocator/geolocator.dart';

class UserController extends GetxController {
  // User model stored as observable
  var user = UserModel(name: '', email: '', phone: '').obs;
  var userLocation = 'Finding you...'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserInfo(); // Load user info when the controller is initialized
    _loadUserLocation(); // Optionally load user location if required
  }

  // Method to update user data after login
  void setUser(UserModel newUser) async {
    user.value = newUser;
    await _saveUserInfo(newUser); // Save user info to SharedPreferences
  }

  // Store user info in SharedPreferences
  Future<void> _saveUserInfo(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode({
      'name': userModel.name,
      'email': userModel.email,
      'phone': userModel.phone,
      'address': userModel.address,
    });
    await prefs.setString('user_info', userJson); // Store user data
  }

  // Load user info from SharedPreferences
  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_info');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      user.value = UserModel(
        name: userMap['name'],
        email: userMap['email'],
        phone: userMap['phone'],
      );
    }
  }

  // Clear user info when logging out
  Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_info'); // Clear stored user data
    user.value = UserModel(name: '', email: '', phone: ''); // Clear user data in app
  }

  // Set user location
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

  // Optionally: Store user location in SharedPreferences
  Future<void> _saveUserLocation(String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_location', location);
  }

  // Optionally: Load user location from SharedPreferences
  Future<void> _loadUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final location = prefs.getString('user_location');
    if (location != null) {
      userLocation.value = location;
    }
  }
}
