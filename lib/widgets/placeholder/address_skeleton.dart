import 'package:flutter/material.dart';

class AddressSkeletonWidget extends StatelessWidget {
  const AddressSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: 5, // Display 5 skeleton items as placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenWidth * 0.02,
          ),
          child: Container(
            height: screenWidth * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300, // Background color for the skeleton
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Row(
                children: [
                  // Circular skeleton for label logo
                  Container(
                    width: screenWidth * 0.1,
                    height: screenWidth * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400, // Logo placeholder color
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  // Skeleton for address details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSkeletonLine(
                          width: screenWidth * 0.3,
                          height: screenWidth * 0.03,
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        _buildSkeletonLine(
                          width: screenWidth * 0.6,
                          height: screenWidth * 0.02,
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        _buildSkeletonLine(
                          width: screenWidth * 0.5,
                          height: screenWidth * 0.02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonLine({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade400, // Line color
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
