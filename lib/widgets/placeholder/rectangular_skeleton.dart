import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RectangularContainerSkeletonPlaceholder extends StatefulWidget {
  final double height;
  const RectangularContainerSkeletonPlaceholder({super.key, required this.height});

  @override
  _RectangularContainerSkeletonPlaceholderState createState() =>
      _RectangularContainerSkeletonPlaceholderState();
}

class _RectangularContainerSkeletonPlaceholderState
    extends State<RectangularContainerSkeletonPlaceholder> {
  @override
  Widget build(BuildContext context) {
    double height = widget.height;// Adjust as needed

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: height,
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
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Skeleton for name
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 4),
                  // Skeleton for description
                  Container(
                    height: 10,
                    width: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 8),
                  // Skeleton for price
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 50,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 10,
                        width: 50,
                        color: Colors.grey.shade300,
                      ),
                    ],
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
