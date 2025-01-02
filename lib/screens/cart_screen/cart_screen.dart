import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:purotaja/controllers/cart_controller.dart';
import 'package:purotaja/controllers/products_controller.dart';
import 'package:purotaja/utils/toast_message.dart';
import '../../app_theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final productsController = Get.put(ProductsController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppTheme.bgGrey,
        appBar: AppBar(
          title: const Text('Checkout'),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
        ),
        body: Obx(() {
          if (cartController.cartItems.isEmpty) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/cart_assets/empty_cart.svg',
                    width: screenWidth * 0.6,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Your cart is empty',
                      style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
            ));
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06, vertical: 30),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius: BorderRadius.circular(
                              15), // Circular border radius
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Obx(() {
                          final allCartItems = cartController.cartItems;
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allCartItems.length,
                                itemBuilder: (context, index) {
                                  var currentProduct =
                                      productsController.getProductById(
                                          allCartItems[index]['id']);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, // Ensures proper spacing
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center, // Centers items vertically
                                      children: [
                                        // Product name and category
                                        Container(
                                          width: screenWidth * 0.2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                currentProduct['name'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                                overflow: TextOverflow
                                                    .ellipsis, // Handle long names
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Quantity control
                                        Container(
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppTheme.bgGrey),
                                            color: Colors
                                                .white, // Background color for the container
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Decrease button
                                              IconButton(
                                                onPressed: () {
                                                  cartController
                                                      .decreaseQuantity(index);
                                                },
                                                icon: const Icon(Icons.remove,
                                                    color: Colors.red),
                                                constraints:
                                                    const BoxConstraints(),
                                                padding: EdgeInsets.zero,
                                              ),
                                              // Quantity text
                                              Text(
                                                allCartItems[index]['quantity']
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              // Increase button
                                              IconButton(
                                                onPressed: () {
                                                  cartController
                                                      .increaseQuantity(index);
                                                },
                                                icon: const Icon(Icons.add,
                                                    color: Colors.green),
                                                constraints:
                                                    const BoxConstraints(),
                                                padding: EdgeInsets.zero,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Price
                                        Container(
                                          width: screenWidth * 0.18,
                                          child: Column(
                                            children: [
                                              if ((currentProduct['discount'] ??
                                                      0) >
                                                  0) ...[
                                                const SizedBox(width: 8),
                                                Text(
                                                  '\u20B9${(currentProduct['price'] * allCartItems[index]['quantity']).toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.grey,
                                                      ),
                                                ),
                                              ],
                                              if ((currentProduct['discount'] ??
                                                      0) >
                                                  0) ...[
                                                Text(
                                                  '\u20B9${((currentProduct['price'] * allCartItems[index]['quantity']) - ((currentProduct['price'] * allCartItems[index]['quantity'] * currentProduct['discount']) / 100)).toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ] else ...[
                                                Text(
                                                  '\u20B9${(currentProduct['price'] * allCartItems[index]['quantity']).toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //Empty and add more items
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly, // Ensures even spacing between the containers
                                children: [
                                  // Empty Cart button
                                  GestureDetector(
                                    onTap: () {
                                      cartController.emptyCart();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            AppTheme.bgGrey, // Background color
                                        border: Border.all(
                                            color: AppTheme
                                                .bgGrey), // Border with same color
                                        borderRadius: BorderRadius.circular(
                                            8), // Rounded corners
                                      ),
                                      padding: const EdgeInsets.all(
                                          10), // Inner padding
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete_outline,
                                            size: screenWidth * 0.05,
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.02,
                                          ),
                                          Text(
                                            'Delete all',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Add More Items button
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/', arguments: 1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            AppTheme.bgGrey, // Background color
                                        border: Border.all(
                                            color: AppTheme
                                                .bgGrey), // Border with same color
                                        borderRadius: BorderRadius.circular(
                                            8), // Rounded corners
                                      ),
                                      padding: const EdgeInsets.all(
                                          10), // Inner padding
                                      child: Row(
                                        children: [
                                          Icon(Icons.add),
                                          SizedBox(
                                            width: screenWidth * 0.02,
                                          ),
                                          Text(
                                            'Add More Items',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
        bottomNavigationBar: Obx(
          () => cartController.cartItems.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showToast("Order placed successfully");
                      Get.toNamed('/');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Pay Now",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ));
  }
}
