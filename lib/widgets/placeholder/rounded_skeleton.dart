import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedSkeletonPlaceholder extends StatelessWidget {
  const RoundedSkeletonPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: SizedBox(
        height: screenWidth * 0.2, // Match the height to your category height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5, // Skeleton placeholders
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Column(
                children: [
                  ClipOval(
                    child: Container(
                      width: screenWidth * 0.15, // Same size as category image
                      height: screenWidth * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // Adjust spacing as needed
                  Container(
                    height: 10, // Skeleton text height
                    width: screenWidth * 0.1, // Match width of category text
                    color: Colors.grey.shade300,
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
