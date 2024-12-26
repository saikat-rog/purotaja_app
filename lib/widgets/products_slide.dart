import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/widgets/placeholder/rectangular_skeleton.dart';
import '../controllers/products_controller.dart';

class ProductsSlideWidget extends StatelessWidget {
  final String categoryId;
  final BuildContext context;
  final bool willRefresh; // New parameter to trigger a refresh
  final productsController = Get.put(ProductsController());

  ProductsSlideWidget({
    super.key,
    required this.categoryId, // Required parameter for dynamic products
    required this.context,
    required this.willRefresh, // Default is false, can be passed as true to refresh
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    // Trigger refresh if willRefresh is true
    if (willRefresh || productsController.productsByCategory.isEmpty) {
      productsController.getAllProductsFromCategoryByCategoryId(categoryId);
    }

    return Obx(() {
      final products = productsController.productsByCategory;
      final isLoading = productsController.isLoading.value;

      if (isLoading) {
        // Display skeleton while fetching data
        return RectangularContainerSkeletonPlaceholder(context: context);
      }

      // Render product list once data is fetched
      return SizedBox(
        height: screenWidth*0.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return SizedBox(
              width: screenWidth*0.5,
              child: Padding(
                padding: EdgeInsets.only(right: screenWidth*0.01, left: screenWidth*0.08),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to the product info page with the product id
                    Get.toNamed('/product/${product['id']}'); // Navigate using the product id
                    // Get.toNamed('/product/675dc6eee898796fe6df63a4');
                    // print(product['id']);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product image
                      Container(
                        height: screenWidth*0.3,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: product['image'] != null && product['image'].isNotEmpty
                            ? Image.network(
                          product['image'][0]['url'],
                          fit: BoxFit.cover,
                        )
                            : Icon(Icons.image, size: screenWidth*0.4),
                      ),
                      const SizedBox(height: 4),
                      // Product name
                      Text(
                        product['name'] ?? 'Unknown',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      // Product description
                      Text(
                        product['description'] ?? 'Unknown Description',
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Product price
                      Row(
                        children: [
                          Text(
                            '\u20B9${product['price'] - ((product['discount']*product['price'])/100 ?? 0)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if ((product['discount'] ?? 0) > 0) ...[
                            const SizedBox(width: 8),
                            Text(
                              '\u20B9${product['price']}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
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
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
