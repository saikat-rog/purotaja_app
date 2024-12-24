import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/products_controller.dart';
import '../../widgets/placeholder/grid_skeleton.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final categoryController = Get.put(CategoryController());
  final productsController = Get.find<ProductsController>();

  dynamic selectedCategoryIndex = 0.obs; // Manage selected index here

  @override
  void initState() {
    super.initState();

    // Get the parameter or use default value 0
    selectedCategoryIndex = int.tryParse(Get.parameters['selectedCategoryIndex'] ?? '0') ?? 0;

    // Fetch products for the initially selected category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productsController.getAllProductsFromCategoryByCategoryId(
        categoryController.categories[selectedCategoryIndex]['id'].toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            GestureDetector(onTap:(){
              //searches
            }, child: Icon(Icons.search, size: screenWidth*0.07)),
          ],
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        toolbarHeight: screenWidth*0.15,
      ),
      // Row for dividing left and right pane
      body: Row(
        children: [
          // Left Pane for Categories
          Container(
            width: screenWidth * 0.2,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.black12, width: 2.0),
              ),
            ),
            child: Obx(() {
              return ListView.builder(
                itemCount: categoryController.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.categories[index];
                  final isSelected = selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index; // Update selected index
                      });
                      productsController.getAllProductsFromCategoryByCategoryId(
                        categoryController.categories[selectedCategoryIndex]['id'].toString(),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Category Icon and Name
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.02),
                            child: Container(
                              width: screenWidth * 0.13,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: category['image'] != null &&
                                        category['image'].isNotEmpty
                                        ? Image.network(
                                      category['image'][0]['url'],
                                      fit: BoxFit.cover,
                                      height: screenWidth * 0.1,
                                      width: screenWidth * 0.1,
                                    )
                                        : Icon(Icons.image, size: screenWidth * 0.1, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    category['name'],
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Selection Bar on the Right Side
                          if (isSelected)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(500),
                                  bottomLeft: Radius.circular(500),
                                ),
                                color: Theme.of(context).primaryColor,
                              ),
                              height: screenWidth * 0.15,
                              width: 5,
                            )
                          else
                            const SizedBox(width: 5), // Placeholder for spacing
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Right Pane for Products
          Expanded(
            child: Obx(() {
              if (productsController.isLoading.value) {
                return GridSkeletonWidget();
              } else if (productsController.productsByCategory.isEmpty) {
                return const Center(
                  child: Text(
                    "No products available",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      crossAxisSpacing: 16.0, // Horizontal spacing between items
                      mainAxisSpacing: 2.0, // Vertical spacing between items
                      childAspectRatio: 0.59, // Adjust card height-to-width ratio
                    ),
                    itemCount: productsController.productsByCategory.length,
                    itemBuilder: (context, index) {
                      final product = productsController.productsByCategory[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/product/${product['id']}');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: screenWidth*0.3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product['image'][0]['url'],
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Product Name
                            Row(
                              children: [
                                Text(
                                  product['name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product['description'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium,
                              maxLines: 2,
                              softWrap: true,
                            ),
                            // Product Price
                            Row(
                              children: [
                                Text(
                                  '\u20B9${product['price'] - (product['discount'] ?? 0)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                if ((product['discount'] ?? 0) > 0) ...[
                                  SizedBox(width: screenWidth*0.01),
                                  Text(
                                    '\u20B9${product['price']}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth*0.01),
                                  Text(
                                    '${product['discount']}% off',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.red),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          )

        ],
      ),
    );
  }
}
