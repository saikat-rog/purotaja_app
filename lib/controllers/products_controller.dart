import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:purotaja/services/api_service.dart';

class ProductsController extends GetxController {
  final ProductApi productApi = ProductApi();

  // Observables
  var productsByCategory = <Map<String, dynamic>>[].obs;
  var allProducts = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var searchQuery = ''.obs; // Search query observable
  var searchResults = <Map<String, dynamic>>[].obs; // Results after searching

  @override
  void onInit() {
    super.onInit();
    getAllProductsFromApi();
  }

  // Fetch products based on category ID
  Future<void> getAllProductsFromCategoryByCategoryId(String id) async {
    isLoading.value = true; // Start loading
    errorMessage.value = ''; // Clear previous errors
    try {
      final fetchedProducts = await productApi.getProductsFromCategories(id);

      // Check if data is not empty
      if (fetchedProducts.isNotEmpty) {
        productsByCategory.assignAll(fetchedProducts); // Update products list
      } else {
        errorMessage.value = "No products found for this category.";
        productsByCategory.clear();
      }
    } catch (e) {
      // Log error in debug mode
      if (kDebugMode) {
        print("Error fetching products: $e");
      }
      errorMessage.value =
          "Failed to load products. Please try again."; // Show user-friendly error
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  dynamic getProductById(String id) {
    return allProducts.firstWhere((product) => product['id'] == id,
        orElse: () => {});
  }

  Future<void> getAllProductsFromApi() async {
    isLoading.value = true; // Start loading
    errorMessage.value = ''; // Clear previous errors
    try {
      final products = await productApi.getAllProducts(); // Fetch all products

      // Check if any products were returned
      if (products.isNotEmpty) {
        // Filter products based on the search query
        allProducts.assignAll(products);
      } else {
        errorMessage.value = "No products found.";
      }
    } catch (e) {
      // Log error in debug mode
      if (kDebugMode) {
        print("Error fetching all products: $e");
      }
      errorMessage.value =
          "Failed to load all products. Please try again."; // Show user-friendly error
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  Future<void> searchProducts(String query) async {
    isLoading.value = true; // Start loading
    errorMessage.value = ''; // Clear previous errors
    try {
      getAllProductsFromApi();

      // Check if any products were returned
      if (allProducts.isNotEmpty) {
        // Filter products based on the search query
        searchResults.assignAll(allProducts.where((product) {
          String name = product['name'].toLowerCase();
          String categoryName = product['category']['name'].toLowerCase();
          return name.contains(query.toLowerCase()) ||
              categoryName.contains(query.toLowerCase());
        }).toList());
      } else {
        errorMessage.value = "No products found.";
      }
    } catch (e) {
      // Log error in debug mode
      if (kDebugMode) {
        print("Error fetching all products: $e");
      }
      errorMessage.value =
          "Failed to load products. Please try again."; // Show user-friendly error
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
