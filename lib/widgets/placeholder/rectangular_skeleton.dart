import 'package:flutter/material.dart';

class RectangularContainerSkeletonPlaceholder extends StatefulWidget {
  final BuildContext context;
  const RectangularContainerSkeletonPlaceholder({super.key, required this.context});

  @override
  _RectangularContainerSkeletonPlaceholderState createState() =>
      _RectangularContainerSkeletonPlaceholderState();
}

class _RectangularContainerSkeletonPlaceholderState
    extends State<RectangularContainerSkeletonPlaceholder> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.08),
      child: SizedBox(
        height: screenWidth*0.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6, // Show a fixed number of placeholders
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Skeleton for image
                  Container(
                    width: screenWidth*0.4,
                    height: screenWidth*0.3,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Skeleton for name
                  Container(
                    height: screenWidth * 0.03,
                    width: screenWidth * 0.3, // 30% of screen width
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 6),
                  // Skeleton for description
                  Container(
                    height: screenWidth * 0.05,
                    width: screenWidth * 0.3, // 30% of screen width
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
