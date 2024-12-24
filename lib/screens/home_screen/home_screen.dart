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
  final categoryController = Get.find<CategoryController>();
  final productsController = Get.find<ProductsController>();
  final homeController = Get.put(HomeController());

  final InternalPermissions internalPermissions = InternalPermissions();

  @override
  void initState() {
    super.initState();
    userController.setUserLocation();
    Future.delayed(const Duration(seconds: 2), () {
      internalPermissions.checkLocationPermission();
    });
  }

  @override
  void dispose() {
    productsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.045, vertical: screenWidth*0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hi Text
                    Obx(() => Text(
                      'Hi, ${userController.user.value.name.split(' ')[0]}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(height: 5),
                    // Location
                    Obx(() => Text(
                      userController.userLocation.value,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2, // Allow wrapping to the next line
                      overflow: TextOverflow.ellipsis, // Truncate if too long
                    )),
                    SizedBox(height: screenHeight*0.02),
                    //Search Box
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.004),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/search');
                        },
                        child: Container(
                          height: screenWidth * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: Colors.black87),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                          child: Row(
                            children: [
                              const Icon(Icons.search, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                'Search...',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Offer banner
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight*0.015),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       color: Colors.amber[200],
              //     ),
              //     width: double.infinity,
              //     padding: EdgeInsets.symmetric(
              //         vertical: screenWidth * 0.04,
              //         horizontal: screenHeight * 0.02),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Exclusive Offer! 50% OFF on your first order.',
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodyMedium
              //               ?.copyWith(fontWeight: FontWeight.bold),
              //         ),
              //         Icon(
              //           Icons.arrow_forward,
              //           color: Colors.black,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Heading1
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Text(
                  'Shop by Categories',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              // Heading2
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.02,
                    horizontal: screenWidth * 0.06),
                child: Text('Freshest fishes just for you and your family!',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: 8),
              // Scrollable Categories
              CategoriesSlideWidget(),
              // Best Sellers and Recommended
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight*0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Best Seller option
                    InkWell(
                      onTap: () {
                        homeController.changeSelectedOption(
                            SelectedOptionState.bestSeller);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Best Sellers',
                            style:
                                Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
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
                        homeController.changeSelectedOption(
                            SelectedOptionState.recommended);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Recommended',
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
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
          return ProductsSlideWidget(
            categoryId: '67531a520fde5d5d4cc4065d',
            key: const ValueKey('bestSeller'),
            willRefresh: true,
            context: context,
          );
        case SelectedOptionState.recommended:
          return ProductsSlideWidget(
            categoryId: '67531a520fde5d5d4cc4065d',
            key: const ValueKey('recommended'),
            willRefresh: true,
            context: context,
          );
        default:
          return const SizedBox.shrink();
      }
    });
  }
}
