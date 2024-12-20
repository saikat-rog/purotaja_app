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
    return Obx(() {
      if (categoryController.isLoading.value) {
        return const RoundedSkeletonPlaceholder();
      } else {
        return SizedBox(
          height: 100,
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
                              width: 70,
                              height: 70,
                            ),
                          )
                        : ClipOval(
                      child: Icon(Icons.beach_access, size: 70,)
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
