import 'package:flutter/material.dart';

class GridSkeletonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items per row
        crossAxisSpacing: 2.0, // Horizontal spacing
        mainAxisSpacing: 4.0, // Vertical spacing
        mainAxisExtent: 400,
        childAspectRatio:
        1, // Ensures the item size is square
      ),
      itemCount: 5, // Number of placeholder items
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for image
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 5),
              // Placeholder for name text
              Container(
                height: 20,
                color: Colors.grey.shade300,
                width: double.infinity,
              ),
              SizedBox(height: 5),
              // Placeholder for price text
              Container(
                height: 20,
                color: Colors.grey.shade300,
                width: 100,
              ),
            ],
          ),
        );
      },
    );
  }
}
