import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:purotaja/controllers/user_controller.dart';

import '../../../app_theme.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {

  final userController = Get.find<UserController>();
  final List<Map<String, dynamic>> profileOptions = [
    {
      "text": "Full Name",
      'icon':"assets/profile_assets/person.svg"
    },
    {
      "text": "Email",
      'icon':"assets/profile_assets/email.svg"
    },
    {
      "text": "Phone",
      'icon':"assets/profile_assets/phone.svg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start of the column
              children: [
                // Name and Photo container
                _buildUserInfo(),
                const SizedBox(height: 20),
                // Account Options List1
                _buildAccountOptionsList(profileOptions),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildUserInfo() {
  return Container(
    width: double.infinity,
    child: Row(
      children: [
        // Photo
        Container(
          child: const Icon(
            Icons.person,
            size: 120,
            color: Colors.black12,
          ),
        ),
        const SizedBox(width: 15),
        // Name and email
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Obx(() => Text(
                userController.user.value.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              )),
              // Email
              Obx(() => Text(
                userController.user.value.email,
                style: Theme.of(context).textTheme.bodyMedium,
              )),
            ],
          ),
        ),
      ],
    ),
  );
}

// Builds a list of account options
Widget _buildAccountOptionsList(List<Map<String, dynamic>> options) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: AppTheme.bgGrey,
    ),
    child: ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      shrinkWrap: true, // Ensures the ListView fits inside the parent
      physics:
      const NeverScrollableScrollPhysics(), // Prevents internal scrolling
      itemCount: options.length,
      itemBuilder: (context, index) {
        final item = options[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              _buildOptionIcon(item['icon']),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['text'],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  index == 0 ?
                  Text(
                    userController.user.value.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ) : index == 1 ?
                  Text(
                    userController.user.value.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ) :
                  Text(
                    userController.user.value.phone,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}

// Builds the icon for each account option
Widget _buildOptionIcon(String iconPath) {
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SvgPicture.asset(iconPath, height: 30),
    ),
  );
}
}


