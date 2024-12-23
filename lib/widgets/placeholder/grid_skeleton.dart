import 'package:flutter/material.dart';

class GridSkeletonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 16.0, // Horizontal spacing between items
        mainAxisSpacing: 16.0, // Vertical spacing between items
        childAspectRatio: 0.59,
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
                height: 100,
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
              //Placeholder for description
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
