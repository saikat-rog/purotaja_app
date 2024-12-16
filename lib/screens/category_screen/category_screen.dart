import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/products_controller.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final categoryController = Get.put(CategoryController());
  final productsController = Get.put(ProductsController());

  dynamic selectedCategoryIndex = 0.obs; // Manage selected index here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
      ),
      // Row for dividing left and right pane
      body: Row(
        children: [
          // Left Pane for Categories
          Container(
            width: 90,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.black12, width: 2.0),
              ),
            ),
            // The Categories list in the left pane
            child: Obx(() {
              return ListView.builder(
                itemCount: categoryController.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index; // Update selected index
                      });
                      productsController.getAllProductsFromCategoryByCategoryId(
                          categoryController.categories[selectedCategoryIndex]
                                  ['id']
                              .toString());
                    },
                    // Left pane each item container
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Category icon
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 3.0, top: 15, bottom: 15),
                          child: Container(
                            width: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: category['image'] != null &&
                                          category['image'].isNotEmpty
                                      ? Image.network(
                                          category['image'][0]['url'],
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50,
                                        )
                                      : const Icon(Icons.image, size: 40),
                                ),
                                const SizedBox(height: 1),
                                Center(
                                  child: Text(
                                    category['name'],
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Selection bar
                        if (selectedCategoryIndex == index)
                          Container(
                            height: 50,
                            width: 5,
                            color: Theme.of(context).primaryColor,
                          )
                        else
                          const SizedBox(width: 5), // Placeholder for spacing
                      ],
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
                return const Center(child: CircularProgressIndicator());
              } else if (productsController.products.isEmpty) {
                return const Center(child: Text("No products available"));
              } else {
                return GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of items per row
                    crossAxisSpacing: 2.0, // Horizontal spacing
                    mainAxisSpacing: 5.0, // Vertical spacing
                    mainAxisExtent: 300,
                    childAspectRatio:
                        1, // Adjust aspect ratio to match item dimensions
                  ),
                  itemCount: productsController.products.length,
                  itemBuilder: (context, index) {
                    final product = productsController.products[index];
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed('/${product['id']}');
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      product['image'][0]
                                          ['url'], // Fetch image dynamically
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(product['name'],style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),),
                              Text(
                                '\u20B9${product['price']}/kg',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
