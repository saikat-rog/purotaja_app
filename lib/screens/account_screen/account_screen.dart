import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:purotaja/app_theme.dart';
import 'package:purotaja/services/auth_service.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/logout_confirmation.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // Account options for different sections
  final List<Map<String, dynamic>> accountsOption1 = [
    {
      "text": "Personal Info",
      "icon": 'assets/profile_assets/person.svg',
      "route": "/personalInfo"
    },
    {
      "text": "Addresses",
      "icon": 'assets/profile_assets/map.svg',
      "route": "/addresses"
    },
  ];

  final List<Map<String, dynamic>> accountsOption2 = [
    {
      "text": "My Orders",
      "icon": 'assets/profile_assets/bag.svg',
      "route": "/myOrders"
    },
    {
      "text": "Favourite",
      "icon": 'assets/profile_assets/fav.svg',
      "route": "/favourite"
    },
    {
      "text": "Notifications",
      "icon": 'assets/profile_assets/bell.svg',
      "route": "/notifications"
    },
  ];

  final List<Map<String, dynamic>> accountsOption3 = [
    {
      "text": "FAQs",
      "icon": 'assets/profile_assets/question.svg',
      "route": "/faqs"
    },
    {
      "text": "User Reviews",
      "icon": 'assets/profile_assets/review.svg',
      "route": "/reviews"
    },
  ];

  final List<Map<String, dynamic>> accountsOption4 = [
    {
      "text": "Logout",
      "icon": 'assets/profile_assets/logout.svg',
      "route": "/auth"
    },
  ];

  AuthService authService = AuthService();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100.0),
              child: Column(
                children: [
                  // Name and Photo container
                  _buildUserInfo(context),
                  const SizedBox(height: 20),
                  // Account Options List1
                  _buildAccountOptionsList(accountsOption1, context),
                  const SizedBox(height: 20),
                  // Account Options List2
                  _buildAccountOptionsList(accountsOption2, context),
                  const SizedBox(height: 20),
                  // Account Options List3
                  _buildAccountOptionsList(accountsOption3, context),
                  const SizedBox(height: 20),
                  // Account Options List4 (Logout)
                  _buildAccountOptionsList(accountsOption4, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Builds user info section (Name and Photo)
  Widget _buildUserInfo(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          // Photo
          Container(
            child: Icon(
              Icons.person,
              size: screenHeight*0.1,
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
  Widget _buildAccountOptionsList(List<Map<String, dynamic>> options, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.bgGrey,
      ),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: screenHeight*0.01),
        shrinkWrap: true, // Ensures the ListView fits inside the parent
        physics: const NeverScrollableScrollPhysics(), // Prevents internal scrolling
        itemCount: options.length,
        itemBuilder: (context, index) {
          final item = options[index];
          return InkWell(
            onTap: () {
              if (item['text'] == 'Logout') {
                _showLogoutConfirmation(context);
              } else {
                Get.toNamed(item['route']);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures space between text and arrow
                children: [
                  Row(
                    children: [
                      _buildOptionIcon(item['icon'], context),
                      const SizedBox(width: 20),
                      Text(
                        item['text'],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  SvgPicture.asset('assets/profile_assets/option_arrow.svg'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  // Builds the icon for each account option
  Widget _buildOptionIcon(String iconPath, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth*0.09,
      width: screenWidth*0.09,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth*0.02),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }

  // Logout confirmation pop up
  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LogoutConfirmation(
          onConfirm: () {
            authService.setAuthenticationStatus(false);
            Get.offNamed('/auth');
          },
        );
      },
    );
  }
}
