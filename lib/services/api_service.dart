import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:purotaja/services/auth_service.dart';
import 'package:purotaja/utils/toast_message.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class UserApi {
  final userController = Get.find<UserController>();
  AuthService authService = AuthService();

  //Creates a new user in database
  Future<String?> createUser(TextEditingController nameController, TextEditingController emailController, TextEditingController phoneController) async {
    Dio dio = Dio();
    var userData = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text
    };

    try {
      // Sending the request
      Response response =
          await dio.post('${dotenv.env["API_URI"]}/register', data: userData);

      if (response.statusCode == 201) {
        showToast('OTP has been sent to your email.');
        return response.data['token'];
      }
    } catch (e) {
      // Handle DioError or other errors
      if (e is DioException) {
        if (e.response != null) {
          // Handle specific response error codes
          switch (e.response!.statusCode) {
            case 400:
              showToast('Invalid input.');
              break;
            case 500:
              showToast(
                  'You already have an account with us. Please login to continue.');
              break;
            default:
              showToast('Something went wrong. Please try again.');
          }
        } else {
          // Handling other errors (network, timeout, etc.)
          showToast(
              'Could not connect to the server. Try again after sometime.');
        }
      } else {
        // Any other kind of error
        showToast('Something went wrong. Please try again.');
      }
    }
    return null;
  }

  //Returns a token for client's id from database based on phone number
  Future<String?> getUser(String phone) async {
    Dio dio = Dio();
    var userData = {'phone': phone};

    try {
      Response response =
          await dio.post('${dotenv.env["API_URI"]}/login', data: userData);

      return response.data['token'];
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          // Handle specific response error codes
          switch (e.response!.statusCode) {
            case 400:
              if (kDebugMode) {
                print(e.response?.data['message']);
              }
              showToast('Invalid input.');
              break;
            case 500:
              if (kDebugMode) {
                print(e.response?.data['message']);
              }
              showToast('You are not registered.');
              break;
            default:
              if (kDebugMode) {
                print(e.response?.data['message']);
              }
              showToast('Something went wrong. Please try again.');
          }
        } else {
          // Handling other errors (network, timeout, etc.)
          showToast(
              'Could not connect to the server. Try again after sometime.');
        }
      } else {
        // Any other kind of error
        showToast('Something went wrong. Please try again.');
      }
      return null;
    }
  }

  //Authenticate user by sending an OTP to user email
  Future<String?> verifyUser(String token, String otp) async {
    Dio dio = Dio();
    var data = {'token': token, 'otp': otp};

    try {
      Response response =
          await dio.post('${dotenv.env["API_URI"]}/verify', data: data);

      final user = response.data['client'];
      userController.setUser(UserModel(
          name: user['name'], email: user['email'], phone: user['phone']));
      authService.setAuthenticationStatus(true);
      Get.offNamed('/');
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          // Handle specific response error codes
          switch (e.response!.statusCode) {
            case 400:
              if (kDebugMode) {
                print(e.response?.data['message']);
              }
              showToast('Invalid input.');
              break;
            case 500:
              if (kDebugMode) {
                print(e.response?.data['message']);
              }
              showToast('Incorrect OTP entered.');
              break;
            default:
              if (kDebugMode) {
                print(e.response?.data['message']);
              }
              showToast('Something went wrong. Please try again.');
          }
        } else {
          // Handling other errors (network, timeout, etc.)
          showToast(
              'Could not connect to the server. Try again after sometime.');
        }
      } else {
        // Any other kind of error
        showToast('Something went wrong. Please try again.');
      }
    }
    return null;
  }

}

class ProductApi {
  final dio = Dio();

  Future<List<Map<String, dynamic>>> getProductCategories() async {
    String storeId = '42af4ea9-2014-4bcb-9db1-983fe108a118';
    try {
      Response response =
          await dio.get('${dotenv.env["API_URI"]}/$storeId/categories');

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['categories']);
      } else {
        throw Exception("Failed to load categories.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching categories: $e");
      }
      return [];
    }
  }
}
