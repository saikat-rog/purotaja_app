import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserApi {
  Future<int> createUser(String name, String email) async {
    Dio dio = Dio();

    try {
      Response response = await dio.post(
        'https://admin.purotaja.com/api/client',
        data: {'name': name, 'email': email, 'phone': '8334066167'},
      );

      if (kDebugMode) {
        print(response.data);
      }
      return response.statusCode ?? -1;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: ${e.message}');
      }
      return -1; // Returning -1 to indicate an error
    } catch (e) {
      if (kDebugMode) {
        print('Other error: $e');
      }
      return -1; // Returning -1 to indicate an error
    }
  }

  Future<Map<String, dynamic>> fetchUser(String email) async {
    Dio dio = Dio();

    try {
      // Send request to fetch all users
      Response response =
          await dio.get('https://admin.purotaja.com/api/client');

      if (response.statusCode == 200) {
        // Get the list of users from the response data
        List<dynamic> users = response.data;

        // Check if any user has the provided email
        final user = users.firstWhere(
          (user) => user['email'] == email,
          orElse: () => null, // Return null if no user matches
        );

        if (user != null) {
          // If user is found, return the user data
          return user;
        } else {
          // Return error if no user found with the provided email
          if (kDebugMode) {
            print('user not found');
          }
          return {'error': 'You are not registered. Please click on Sign up button'};
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch users: ${response.statusCode}');
        }
        return {'error': 'Internal error! We wil be back'};
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user: $e');
      }
      return {'error': 'Server error.'};
    }
  }
}
