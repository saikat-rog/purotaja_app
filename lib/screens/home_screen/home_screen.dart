import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/controllers/home_controller.dart';
import 'package:purotaja/services/api_service.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/products_controller.dart';
import '../../controllers/user_controller.dart';
import '../../services/auth_service.dart';
import '../../utils/internal_permissions.dart';
import '../../widgets/categories_slide.dart';
import '../../widgets/products_slide.dart';
import '../../widgets/testimonials_slide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AuthService authService = AuthService();
  final ProductApi productApi = ProductApi();

  final userController = Get.find<UserController>();
  final categoryController = Get.put(CategoryController());
  final productsController = Get.put(ProductsController());
  final homeController = Get.put(HomeController());

  final InternalPermissions internalPermissions = InternalPermissions();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userController.setUserLocation();
    Future.delayed(const Duration(seconds: 2), () {
      internalPermissions.checkLocationPermission();
    });
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
            Obx(() => Text(
              'Hi, ${userController.user.value.name.split(' ')[0]}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 5),
            Obx(() => Text(
              userController.userLocation.value,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2, // Allow wrapping to the next line
              overflow: TextOverflow.ellipsis, // Truncate if too long
            )),
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.amber[200],),
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading1
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Text(
                  'Shop by Categories',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              // Heading2
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Text('Freshest fishes just for you and your family!'),
              ),
              const SizedBox(height: 8),
              // Scrollable Categories
              CategoriesSlideWidget(),
              // Best Sellers and Recommended
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Best Seller option
                    InkWell(
                      onTap: () {
                        homeController.changeSelectedOption(SelectedOptionState.bestSeller);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Best Sellers',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 120, // Consistent width for underline
                            color: homeController.selectedOptionState.value ==
                                SelectedOptionState.bestSeller
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    // Recommended option
                    InkWell(
                      onTap: () {
                        homeController.changeSelectedOption(SelectedOptionState.recommended);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Recommended',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 120, // Consistent width for underline
                            color: homeController.selectedOptionState.value ==
                                SelectedOptionState.recommended
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ProductSlide
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _buildProductSlideOnClick(),
              ),
              // Testimonials
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Text(
                  'What our customers say',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Text('Hear it directly from people like you!'),
              ),
              const SizedBox(height: 8),
              TestimonialsSlideWidget()
            ],
          );
        }),
      ),
    );
  }

  // Building product slide upon click on Best seller or Recommendation
  Widget _buildProductSlideOnClick() {
    return Obx(() {
      switch (homeController.selectedOptionState.value) {
        case SelectedOptionState.bestSeller:
          return ProductsSlideWidget(categoryId: '67531a520fde5d5d4cc4065d', key: const ValueKey('bestSeller'), willRefresh: true,);
        case SelectedOptionState.recommended:
          return ProductsSlideWidget(categoryId: '67531a520fde5d5d4cc4065d', key: const ValueKey('recommended'), willRefresh: true,);
        default:
          return const SizedBox.shrink();
      }
    });
  }

}
