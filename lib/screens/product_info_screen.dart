import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; // Import the package
import '../controllers/products_controller.dart';
import '../widgets/products_slide.dart';

class ProductInfoScreen extends StatefulWidget {
  final String productId;

  const ProductInfoScreen({super.key, required this.productId});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();
    final product = productsController.getProductById(widget.productId);

    // Dropdown values
    List<int> quantityOptions = [1, 2, 3, 4, 5];
    List<String> cutTypeOptions = [];
    if (product['subcategories'] != null &&
        product['subcategories'].length > 0) {
      cutTypeOptions = product['subcategories']
          .map<String>(
              (subcategory) => subcategory['name']?.toString() ?? 'Unknown')
          .toList();
    }

    // Selected values for the dropdowns
    Rx<int> selectedQuantity = Rx<int>(quantityOptions[0]);
    Rx<String> selectedCutType = cutTypeOptions.isNotEmpty
        ? Rx<String>(cutTypeOptions[0])
        : Rx<String>('No options available');

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                //Product name
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'] ?? 'Product Name',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(product['description'] ?? 'Product description',
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: product['image'] != null &&
                                product['image'].isNotEmpty
                            ? PageView.builder(
                                itemCount: product['image'].length,
                                itemBuilder: (context, index) {
                                  return Image.network(
                                    product['image'][index]['url'],
                                    fit: BoxFit.fitHeight,
                                  );
                                },
                              )
                            : const Icon(
                                Icons.image,
                                size: 80,
                                color: Colors.grey,
                              ),
                      ),
                      const SizedBox(height: 25),
                      // Price and Discount
                      Row(
                        children: [
                          Text(
                            '\u20B9${product['price'] - (product['discount'] ?? 0)}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if ((product['discount'] ?? 0) > 0) ...[
                            const SizedBox(width: 8),
                            Text(
                              '\u20B9${product['price']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${product['discount']}% off',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.red),
                            ),
                          ],
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
                              SizedBox(height: screenHeight * 0.02),
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
                                            child: Text(
                                              '$value',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ))
                                      .toList(),
                                  buttonStyleData: ButtonStyleData(
                                    height: screenHeight * 0.05,
                                    width: screenWidth * 0.2,
                                    padding:
                                        EdgeInsets.all(screenWidth * 0.015),
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
                              SizedBox(height: screenHeight * 0.02),
                              DropdownButton2<String>(
                                underline: SizedBox.shrink(),
                                value: cutTypeOptions.isNotEmpty
                                    ? selectedCutType.value
                                    : null,
                                onChanged: cutTypeOptions.isNotEmpty
                                    ? (String? newValue) {
                                        if (newValue != null) {
                                          selectedCutType.value = newValue;
                                        }
                                      }
                                    : null,
                                items: cutTypeOptions.isNotEmpty
                                    ? cutTypeOptions.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        );
                                      }).toList()
                                    : null,
                                buttonStyleData: ButtonStyleData(
                                  height: screenHeight * 0.06,
                                  width: screenWidth * 0.3,
                                  padding: EdgeInsets.all(screenWidth * 0.015),
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
                              )
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
                          'You may also like:',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                // Product Image (Swipe able Images)
                ProductsSlideWidget(
                  categoryId: '67531a520fde5d5d4cc4065d',
                  willRefresh: false,
                  context: context,
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
          // Fixed bar to add to cart
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenWidth * 0.3,
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                          ),
                          Text(
                              'MRP: \u20B9${product['price']} (Incl. of all taxes)',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add to cart functionality goes here
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(screenWidth * 0.04, screenWidth * 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center content horizontally
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Center content vertically
                          children: [
                            Text('Add',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: Colors.white)),
                            SizedBox(
                                width:
                                    8), // Reduced spacing for better alignment
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: screenWidth*0.05, // Adjust size to match the text
                            ),
                          ],
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
        ],
      ),
    );
  }
}
