import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/controllers/category_controller.dart';
import './placeholder/rounded_skeleton.dart';

class CategoriesSlideWidget extends StatelessWidget {
  final categoryController = Get.put(CategoryController());
  CategoriesSlideWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(() {
      if (categoryController.isLoading.value) {
        return const RoundedSkeletonPlaceholder();
      } else {
        return SizedBox(
          height: screenWidth*0.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryController.categories.length,
            itemBuilder: (context, index) {
              final category = categoryController.categories[index];
              return Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Column(
                  children: [
                    category['image'] != null && category['image'].isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              category['image'][0]['url'],
                              fit: BoxFit.cover,
                              width: screenWidth*0.15,
                              height: screenWidth*0.15,
                            ),
                          )
                        : ClipOval(
                      child: Icon(Icons.beach_access, size: screenWidth*0.15,)
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category['name'] ?? 'Unknown',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    });
  }
}
