import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';

import '../app_theme.dart';

class LogoutConfirmation extends StatefulWidget {
  final VoidCallback onConfirm; // Callback for when the user confirms logout

  LogoutConfirmation({required this.onConfirm});

  @override
  State<LogoutConfirmation> createState() => _LogoutConfirmationState();
}

class _LogoutConfirmationState extends State<LogoutConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Height of the bottom sheet
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close the bottom sheet without logging out
                  },
                  child: Text('Stay logged in'),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onConfirm(); // Execute the callback
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set background color to grey
                  ),
                  child: Text('Yes', style: Theme.of(context).textTheme.headlineSmall,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
