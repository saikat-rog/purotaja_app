import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/services/api_service.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/auth_service.dart';
import '../../utils/internal_permissions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final userController = Get.find<UserController>();
final AuthService authService = AuthService();
final ProductApi productApi = ProductApi();

final InternalPermissions internalPermissions = InternalPermissions();
final TextEditingController _searchController = TextEditingController();
final categoryController = Get.put(CategoryController());


late Future<List<Map<String, dynamic>>> categoriesFuture;

@override
void initState() {
  super.initState();
  userController.setUserLocation();
  Future.delayed(const Duration(seconds: 2), () {
    internalPermissions.checkLocationPermission();
  });

  // Fetch categories
  categoriesFuture = productApi.getProductCategories();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      toolbarHeight: 220,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
                () => Text(
              'Hi, ${userController.user.value.name.split(' ')[0]}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Obx(
                () => Text(
              userController.userLocation.value,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2, // Allow wrapping to the next line
              overflow: TextOverflow.ellipsis, // Truncate if too long
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.amber[200],
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exclusive Offer! 50% OFF on your first order.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    body: SingleChildScrollView(
      child: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (categoryController.categories.isEmpty) {
          return const Center(child: Text('No categories available.'));
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shop by Categories',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Text(
                'Freshest fishes just for you and your family!',
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 20,
                runSpacing: 20,
                children: categoryController.categories.map((category) {
                  return Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black12,
                        ),
                        child: category['image'] != null && category['image'].isNotEmpty
                            ? ClipOval(
                          child: Image.network(
                            category['image'][0]['url'], // Accessing the first image URL
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        )
                            : const Icon(Icons.image, size: 40),
                      ),
                      Text(category['name'] ?? 'Unknown'),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }),
    ),
  );
}
}
