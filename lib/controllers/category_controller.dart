import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:purotaja/services/api_service.dart';

class CategoryController extends GetxController {
  final ProductApi productApi = ProductApi();
  var categories = <Map<String, dynamic>>[].obs;  // Reactive List
  var isLoading = false.obs;  // Loading state

  @override
  void onInit() {
    super.onInit();
    fetchCategories();  // Fetch categories when the controller is initialized
  }

  void fetchCategories() async {
    isLoading.value = true;
    try {
      final fetchedCategories = await productApi.getProductCategories();
      categories.assignAll(fetchedCategories);  // Update the list reactively
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching categories: $e");
      }
    } finally {
      isLoading.value = false;  // Set loading to false when finished
    }
  }
}

