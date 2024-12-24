import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/products_controller.dart';

class TestimonialsSlideWidget extends StatelessWidget {
  final double height;
  final int itemCount;
  final productsController = Get.find<ProductsController>();

  TestimonialsSlideWidget({
    super.key,
    this.height = 250,
    this.itemCount = 5
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    child: const Icon(Icons.image, size: 40),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
