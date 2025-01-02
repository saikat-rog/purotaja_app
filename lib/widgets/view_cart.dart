import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/controllers/cart_controller.dart';
import '../app_theme.dart';
import '../controllers/products_controller.dart';

class ViewCartWidget extends StatelessWidget {
  final double height;
  final int itemCount;
  final productsController = Get.find<ProductsController>();

  ViewCartWidget({
    super.key,
    this.height = 250,
    this.itemCount = 5
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return GestureDetector(
      onTap: () {
        // Navigate to the cart screen
        Get.toNamed('/cart');
      },
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppTheme.bgGrey, // Set the background color
        ),
        margin: const EdgeInsets.only(
            bottom: 8), // Space between cart box and navbar
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cartController.cartItems.length > 1 ?
              'Your cart has (${cartController.cartItems.length} items)' : 'Your cart has (${cartController.cartItems.length} item)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed('/cart');
                },
                child: Text(
                  "View Cart",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
