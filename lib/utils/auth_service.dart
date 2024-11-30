import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class AuthService {
  Future<void> signUp(TextEditingController nameController,
      TextEditingController emailController) async {
    final UserApi userApi = UserApi();

    final resCode =
        await userApi.createUser(nameController.text, emailController.text);
    if (resCode == 201) {
      // Successfully created the user
      if (kDebugMode) {
        print('User created');
      }
      setAuthenticationStatus(true);
      Get.offNamed('/');
    } else {
      if (kDebugMode) {
        print('Error: $resCode');
      }
    }
  }

  Future<String> logIn(TextEditingController emailController) async {
    final UserApi userApi = UserApi();

    // Fetch the user data using the email
    final user = await userApi.fetchUser(emailController.text);

    // if there's an error
    if (user.containsKey('error')) {
      if (kDebugMode) {
        print(user['error']);
      }
      return user['error']; // Return the error message
    } else {
      if (kDebugMode) {
        print('User details: $user');
      }

      // Set authentication status and navigate to the home screen
      setAuthenticationStatus(true);
      Get.offNamed('/');

      return 'Welcome, ${user['name']}!'; // Return success message
    }
  }

  Future<void> setAuthenticationStatus(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', isAuthenticated);
  }

  Future<bool> getAuthenticationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuthenticated') ?? false; // Default to false
  }
}
