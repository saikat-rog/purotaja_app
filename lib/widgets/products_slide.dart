import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/widgets/placeholder/rectangular_skeleton.dart';
import '../controllers/products_controller.dart';

class ProductsSlideWidget extends StatelessWidget {
  final String categoryId; // List of products
  final double height;
  final bool willRefresh; // New parameter to trigger a refresh
  final productsController = Get.put(ProductsController());

  ProductsSlideWidget({
    Key? key,
    required this.categoryId, // Required parameter for dynamic products
    this.height = 250, // Optional height with a default value
    required this.willRefresh, // Default is false, can be passed as true to refresh
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger refresh if willRefresh is true
    if (willRefresh || productsController.products.isEmpty) {
      productsController.getAllProductsFromCategoryByCategoryId(categoryId);
    }

    return Obx(() {
      final products = productsController.products;
      final isLoading = productsController.isLoading.value;

      if (isLoading) {
        // Display skeleton while fetching data
        return RectangularContainerSkeletonPlaceholder(height: height);
      }

      if (products.isEmpty) {
        // Show empty state if no products are available
        return Center(
          child: Text(
            'No products available.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }

      // Render product list once data is fetched
      return SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 30),
              child: GestureDetector(
                onTap: () {
                  // Navigate to the product info page with the product id
                  Get.toNamed('/product/${product['id']}'); // Navigate using the product id
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.black12,
                      ),
                      child: product['image'] != null && product['image'].isNotEmpty
                          ? Image.network(
                        product['image'][0]['url'],
                        fit: BoxFit.cover,
                      )
                          : const Icon(Icons.image, size: 40),
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
                    ),
                    // Product price
                    Row(
                      children: [
                        Text(
                          '\u20B9${product['price'] - (product['discount'] ?? 0)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if ((product['discount'] ?? 0) > 0) ...[
                          const SizedBox(width: 8),
                          Text(
                            '\u20B9${product['price']}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${product['discount']}% off',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.red),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
