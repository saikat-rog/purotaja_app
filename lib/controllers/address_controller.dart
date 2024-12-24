import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purotaja/controllers/user_controller.dart';
import 'package:purotaja/services/api_service.dart';

class AddressController extends GetxController {
  UserApi userApi = UserApi();
  var address = {}.obs; // Instead of a list, use a map to store the address
  var addresses = [].obs;
  var isLoading = false.obs; // Define the loading state

  var isDefault = false.obs;

  final userController = Get.find<UserController>();
  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  //Get Address By ID
  // Get Address By ID
  Future<void> getAddressByAddressId(String addressId) async {
    isLoading.value = true; // Set loading to true before starting the search

    try {
      // Fetch addresses first if not already done
      await fetchAddresses();

      // Search for the address by addressId in the reactive addresses list
      final addressData = addresses.firstWhere(
            (address) => address['id'] == addressId, // Condition to match the addressId
        orElse: () => null, // Return null if no matching address is found
      );

      if (addressData != null) {
        // Successfully found the address, return the addressData
        address.value = addressData;
      } else {
        // No address found with the given addressId
        Get.snackbar("Not Found", "Address not found for the provided ID.");
      }
    } catch (e) {
      // Handle any errors (optional)
      Get.snackbar("Error", "Failed to fetch the address.");
    } finally {
      isLoading.value = false; // Set loading to false after the operation is complete
    }
  }

  // Fetch addresses for the logged-in user
  Future<void> fetchAddresses() async {
    isLoading.value = true; // Set loading to true before starting the API call
    try {
      String userId = userController.user.value.id;
      final fetchedAddresses = await userApi.fetchUserAddresses(userId);
      addresses.value = fetchedAddresses;
    } catch (e) {
      // Handle any errors (optional)
      print(e);
      Get.snackbar("Error", "Failed to load addresses.");
    } finally {
      isLoading.value =
          false; // Set loading to false after the API call is complete
    }
  }

  // Create a new address for the logged-in user
  Future<void> createAddress(
      TextEditingController addressController,
      TextEditingController streetController,
      TextEditingController apartmentController,
      TextEditingController postalCodeController,
      String label,
      bool isDefault) async {
    isLoading.value = true; // Set loading to true before starting the API call
    final addressData = {
      "address": addressController.text,
      "street": streetController.text,
      "appartment": apartmentController.text,
      "postalCode": postalCodeController.text,
      "label": label,
      "isDefault": isDefault,
    };
    try {
      final userId = userController.user.value.id.toString();
      await userApi.createUserAddresses(userId, addressData);
      fetchAddresses();
    } catch (e) {
      // Handle any errors (optional)
      Get.snackbar("Error", '$e');
    } finally {
      isLoading.value =
          false; // Set loading to false after the API call is complete
    }
  }

  // Update an existing address for the logged-in user
  Future<void> updateAddress(
      String addressId,
      TextEditingController addressController,
      TextEditingController streetController,
      TextEditingController apartmentController,
      TextEditingController postalCodeController,
      String label,
      bool isDefault) async {
    isLoading.value = true; // Set loading to true before starting the API call
    final addressData = {
      "address": addressController.text,
      "street": streetController.text,
      "appartment": apartmentController.text,
      "postalCode": postalCodeController.text,
      "label": label,
      "isDefault": isDefault,
    };
    try {
      final userId = userController.user.value.id;
      await userApi.updateUserAddresses(userId, addressId, addressData);
      fetchAddresses();
    } catch (e) {
      // Handle any errors (optional)
      Get.snackbar("Error", "Failed to update address.");
    } finally {
      isLoading.value =
          false; // Set loading to false after the API call is complete
    }
  }

  // Delete an address for the logged-in user
  Future<void> deleteAddress(String addressId) async {
    isLoading.value = true; // Set loading to true before starting the API call
    try {
      final userId = userController.user.value.id;
      await userApi.deleteUserAddresses(userId, addressId);
      await fetchAddresses(); // Fetch addresses again after deletion
    } catch (e) {
      // Handle any errors (optional)
      Get.snackbar("Error", "Failed to delete address.");
    } finally {
      isLoading.value =
          false; // Set loading to false after the API call is complete
    }
  }

  // Remove an address locally by index
  void removeAddress(int index) {
    if (index < addresses.length) {
      addresses.removeAt(index);
    } else {
      Get.snackbar("Error", "Invalid index.");
    }
  }
}
