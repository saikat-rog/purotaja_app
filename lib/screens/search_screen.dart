import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/app_theme.dart';
import 'package:purotaja/controllers/products_controller.dart';

class SearchScreen extends StatelessWidget {
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: screenWidth*0.12,
          child: TextField(
            decoration: InputDecoration(
              fillColor: AppTheme.bgGrey,
              filled: true,
              hintText: "Search for products...",hintStyle: Theme.of(context).textTheme.bodyLarge,
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (query) {
              // Call the search method with the query
              productsController.searchProducts(query);
            },
          ),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // Show loading indicator while fetching data
            Obx(() {
              if (productsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (productsController.errorMessage.value.isNotEmpty) {
                return Center(child: Text(productsController.errorMessage.value));
              } else if (productsController.searchResults.isEmpty) {
                return Center(child: Text("No product found", style: Theme.of(context).textTheme.bodyLarge,));
              } else {
                // Show search results
                return Expanded(
                  child: ListView.builder(
                    itemCount: productsController.searchResults.length,
                    itemBuilder: (context, index) {
                      final product = productsController.searchResults[index];

                      // Safely extract fields and ensure they're non-null
                      final imageUrl = product['image'] != null && product['image'].isNotEmpty
                          ? product['image'][0]['url'] ?? ''
                          : '';
                      final productName = product['name'] ?? 'Unknown Product';
                      final productDescription = product['description'] ?? 'No description available';

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        leading: imageUrl.isNotEmpty
                            ? Image.network(
                          imageUrl,
                          width: screenWidth*0.2,
                          fit: BoxFit.fitHeight,
                        )
                            : Icon(Icons.image, size: 50),
                        title: Text(productName, style: Theme.of(context).textTheme.headlineSmall,),
                        subtitle: Text(productDescription, style: Theme.of(context).textTheme.bodySmall,),
                        onTap: () {
                          // Ensure the correct ID is used
                          Get.toNamed('/product/${product['id']}');
                        },
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
