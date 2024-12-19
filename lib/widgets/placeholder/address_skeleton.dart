import 'package:flutter/material.dart';

class AddressSkeletonWidget extends StatelessWidget {
  final bool isLoading;
  final bool noAddresses;

  AddressSkeletonWidget({this.isLoading = false, this.noAddresses = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Show 5 skeleton items as an example
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300, // Background for the skeleton
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  // Circular skeleton for label logo
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300, // Grey color for skeleton
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 30),
                  // Skeleton for address text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSkeletonText(width: 100),
                        SizedBox(height: 8),
                        _buildSkeletonText(width: 200),
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

  Widget _buildSkeletonText({required double width}) {
    return Container(
      width: width,
      height: 12.0,
      color: Colors.grey[400], // Skeleton text color
    );
  }
}
