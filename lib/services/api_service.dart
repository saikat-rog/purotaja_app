import 'dart:convert';

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
          id: user['id'], name: user['name'], email: user['email'], phone: user['phone']));
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

  Future<dynamic> fetchUserAddresses(String userId) async {
    Dio dio = Dio();

    try {
      Response response =
      await dio.get('${dotenv.env["API_URI"]}/client/$userId/address');

      final addresses = response.data['addresses'];
      return addresses;

    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          if (kDebugMode) {
            print(e.response?.data['message']);
          }
          showToast(e.response?.data['message']);
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

  Future<void> createUserAddresses(String userId, var userAddressData) async {
    Dio dio = Dio();

    try {
      Response response =
      await dio.post('${dotenv.env["API_URI"]}/client/$userId/address', data: userAddressData);

    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          if (kDebugMode) {
            print(e.response?.data['message']);
          }
          showToast(e.response?.data['message']);
        } else {
          // Handling other errors (network, timeout, etc.)
          showToast(
              'Could not connect to the server. Try again after sometime.');
        }
      } else {
        // Any other kind of error
        // print(e);
        showToast('Something went wrong. Please try again.');
      }
    }
  }

  Future<void> updateUserAddresses(String userId, String addressId, var userAddressData) async {
    Dio dio = Dio();

    try {
      Response response =
      await dio.post('${dotenv.env["API_URI"]}/client/$userId/address/$addressId', data: userAddressData);

      showToast(response.data['message']);

    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          if (kDebugMode) {
            print(e.response?.data['message']);
          }
          showToast(e.response?.data['message']);
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

  Future<void> deleteUserAddresses(String userId, String addressId) async {
    Dio dio = Dio();

    try {
      Response response =
      await dio.delete('${dotenv.env["API_URI"]}/client/$userId/address/$addressId');

      showToast(response.data['message']);

    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          if (kDebugMode) {
            print(e.response?.data['message']);
          }
          showToast(e.response?.data['message']);
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
          await dio.get('${dotenv.env["API_URI"]}/${dotenv.env["STORE_ID"]}/categories');

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

  Future<List<Map<String, dynamic>>> getProductsFromCategories(String categoryId) async {
    try {
      // Send GET request to fetch category data
      Response response = await dio.get(
        '${dotenv.env["API_URI"]}/${dotenv.env["STORE_ID"]}/categories/$categoryId',
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Safely extract products from the response
        final products = response.data['category']['product'] as List<dynamic>;
        return products.map((product) => Map<String, dynamic>.from(product)).toList();
      } else {
        throw Exception("Failed to load products.");
      }
    } catch (e) {
      // Log the error for debugging purposes
      if (kDebugMode) {
        print("Error fetching products: $e");
      }
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    try {
      Response response = await dio.get('${dotenv.env["API_URI"]}/${dotenv.env["STORE_ID"]}/products');

      if (response.statusCode == 200) {
        // Safely extract all products from the response
        final products = response.data['products'] as List<dynamic>;
        return products.map((product) => Map<String, dynamic>.from(product)).toList();
      } else {
        throw Exception("Failed to load all products.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching all products: $e");
      }
      return [];
    }
  }
}
