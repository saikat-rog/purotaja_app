import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:purotaja/services/api_service.dart';

class ProductsController extends GetxController {
  final ProductApi productApi = ProductApi();

  // Observables
  var products = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Fetch products based on category ID
  Future<void> getAllProductsFromCategoryByCategoryId(String id) async {
    isLoading.value = true; // Start loading
    errorMessage.value = ''; // Clear previous errors
    try {
      final fetchedProducts = await productApi.getProductsFromCategories(id);

      // Check if data is not empty
      if (fetchedProducts.isNotEmpty) {
        products.assignAll(fetchedProducts); // Update products list
      } else {
        errorMessage.value = "No products found for this category."; // Handle empty state
      }
    } catch (e) {
      // Log error in debug mode
      if (kDebugMode) {
        print("Error fetching products: $e");
      }
      errorMessage.value = "Failed to load products. Please try again."; // Show user-friendly error
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  dynamic getProductById(String id) {
    return products.firstWhere((product) => product['id'] == id, orElse: () => {});
  }


}
