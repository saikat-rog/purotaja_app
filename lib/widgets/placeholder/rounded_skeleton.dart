import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedSkeletonPlaceholder extends StatelessWidget{
  const RoundedSkeletonPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  ClipOval(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 5,
                    width: 60,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}