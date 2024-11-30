import 'package:get/get.dart';
import 'package:purotaja/services/api_service.dart';

class CategoryController extends GetxController {
  final ProductApi productApi = ProductApi();
  var categories = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    isLoading.value = true;
    try {
      final fetchedCategories = await productApi.getProductCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
