import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:purotaja/utils/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  // final userController = Get.find<UserController>();
  //
  // Future<String?> generateToken(TextEditingController nameController, TextEditingController emailController, TextEditingController phoneController,) async {
  //   final UserApi userApi = UserApi();
  //
  //   try {
  //     // Attempt to create user and get the response
  //     final response = await userApi.createUser(
  //       nameController.text,
  //       emailController.text,
  //       phoneController.text,
  //     );
  //
  //     // If the response is successful, return the token
  //     if (response['success'] == true) {
  //       if (kDebugMode) {
  //         print(response['message']);
  //       }
  //       showToast('OTP has been sent to your email');
  //       return response['token'];
  //     }
  //
  //     // If not successful, print and show the message from response
  //     if (kDebugMode) {
  //       print(response['message']);
  //     }
  //     showToast(response['message']);
  //     return null;
  //   } catch (e) {
  //     // General error handler for unexpected exceptions
  //     if (kDebugMode) {
  //       print('Error: $e');
  //     }
  //     showToast('Could not connect to the server.');
  //     return null;
  //   }
  // }
  //
  //
  // Future<String?> getToken(TextEditingController phoneController) async {
  //   final UserApi userApi = UserApi();
  //
  //   try{
  //     final response = await userApi.getUser(phoneController.text);
  //     if(response['success'] == true){
  //       if (kDebugMode) {
  //         print(response['message']);
  //       }
  //       showToast('OTP has been sent to your email');
  //       return response['token'];
  //     }
  //     if (kDebugMode) {
  //       print(response['message']);
  //     }
  //     showToast('Could not send OTP, please try again.');
  //     return null;
  //   }
  //   catch(e){
  //     if (kDebugMode) {
  //       print('Error:$e');
  //     }
  //     showToast('Could not connect to the server.');
  //     return null;
  //   }
  // }
  //
  // Future<void> verifyToken(String token, String otp) async {
  //   final UserApi userApi = UserApi();
  //
  //   final response = await userApi.verifyUser(token, otp);
  //
  //   if (response['success'] == true) {
  //     // Set authentication status and navigate to the home screen
  //     final user = response['client'];
  //     userController.setUser(UserModel(name: user['name'], email: user['email'], phone: 'phone'));
  //     setAuthenticationStatus(true);
  //     Get.offNamed('/');
  //   } else {
  //     showToast('Incorrect OTP');
  //   }
  // }

  Future<void> setAuthenticationStatus(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', isAuthenticated);
  }

  Future<bool> getAuthenticationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuthenticated') ?? false; // Default to false
  }
}
