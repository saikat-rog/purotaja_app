import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; // Import the package
import '../controllers/products_controller.dart';
import '../widgets/products_slide.dart';

class ProductInfoScreen extends StatelessWidget {
  final String productId;

  const ProductInfoScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();
    final product = productsController.getProductById(productId);

    // Dropdown values
    List<int> quantityOptions = [1, 2, 3, 4, 5];
    List<String> cutTypeOptions = [product['subcategories'][0]['name'], product['subcategories'][1]['name']];

    // Selected values for the dropdowns
    Rx<int> selectedQuantity = Rx<int>(quantityOptions[0]);
    Rx<String> selectedCutType = Rx<String>(cutTypeOptions[0]);

    return Scaffold(
      appBar: AppBar(
        title: Text(product['name'] ?? 'Product Info'),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 70),
                  // Product Image
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: product['image'] != null && product['image'].isNotEmpty
                        ? Image.network(
                      product['image'][0]['url'],
                      fit: BoxFit.cover,
                    )
                        : const Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Product Name
                  Text(
                    product['name'] ?? 'Unknown Product',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Price and Discount
                  Row(
                    children: [
                      Text(
                        '\u20B9${product['price'] - product['discount']}' ?? '0',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
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
                        '${product['discount']}% off' ?? '0',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Qty and Cut type dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Dropdown for Quantity
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quantity',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Obx(() {
                            return DropdownButton2<int>(
                              underline: SizedBox.shrink(),
                              value: selectedQuantity.value,
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  selectedQuantity.value = newValue;
                                }
                              },
                              items: quantityOptions
                                  .map((int value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              ))
                                  .toList(),
                              buttonStyleData: ButtonStyleData(
                                height: 40,
                                width: 80,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.black12),
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      // Dropdown for Cut Type
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cut Type',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Obx(() {
                            return DropdownButton2<String>(
                              underline: SizedBox.shrink(),
                              value: selectedCutType.value, // Use `.value` to get the actual string
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  selectedCutType.value = newValue; // Update the reactive value
                                }
                              },
                              items: cutTypeOptions
                                  .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                                  .toList(),
                              buttonStyleData: ButtonStyleData(
                                height: 40,
                                width: 120,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.black12),
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }),

                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  // "About this item" Heading
                  Text(
                    'About this item',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    product['description'] ?? 'No description available.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  // 'You may also like', Heading
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'You may also like',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  ProductsSlideWidget(categoryId: '67531a520fde5d5d4cc4065d'),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120, // Increased height to accommodate both price info and MRP text
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price info on the left side
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u20B9${product['price'] - product['discount']}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'MRP: \u20B9${product['price']} (INCL. OF ALL TAXES)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add to cart functionality goes here
                        },
                        child: Row(
                          children: [
                            Text('Add'),
                            SizedBox(width: 10,),
                            Icon(
                              Icons.add, // Icon to represent the cart
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // MRP info below price
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // Bottom fixed bar to add to cart
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 100,
          //     color: Colors.white,
          //     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         // Price info on the left side
          //         Text(
          //           '\u20B9${product['price'] - product['discount']}',
          //           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         // Add button on the right side
          //         ElevatedButton(
          //           onPressed: () {
          //             // Add to cart functionality goes here
          //           },
          //           child: Text('Add'),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

}
