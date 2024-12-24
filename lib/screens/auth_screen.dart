import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/services/api_service.dart';
import 'package:purotaja/widgets/top_banner.dart';

enum AuthState { login, signup, verify }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeySignUp = GlobalKey<FormState>();
  AuthState currentAuthState = AuthState.signup;
  UserApi userApi = UserApi();
  late bool _isLoading = false;
  int _resendTimer = 30;
  var userToken = ''.obs;
  void setToken(String value) {
    userToken.value = value;
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final topBannerController = Get.put(TopBannerController());

  void startResendTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  // Initialize the timer in initState
  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          TopBanner(),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Dynamic padding
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    // The image of the logo
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth*0.08),
                      child: Image.asset(
                        'assets/purotaja_logo.png',
                        width: screenWidth * 0.4,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    // Auth form for login or signup
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: _buildAuthForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5), // Grey overlay
              child: const Center(
                child: CircularProgressIndicator(), // Loading indicator
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildAuthForm() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    switch (currentAuthState) {
      case AuthState.signup:
        return SizedBox(
          key: const ValueKey<AuthState>(AuthState.signup),
          child: Form(
            key: _formKeySignUp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a New \nAccount',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Create an account and get started',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                // Name Field
                SizedBox(
                  height: screenHeight*0.07,
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required.';
                      }
                      if (value.trim().length < 3) {
                        return 'Name must be at least 3 characters long.';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Name can only contain letters and spaces.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight*0.02),
                // Email Field
                SizedBox(
                  height: screenHeight*0.07,
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required.';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight*0.02),
                // Phone Field
                SizedBox(
                  height: screenHeight*0.101,
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone number is required.';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight*0.02),
                // Continue Button
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenWidth*0.02),
                  child: SizedBox(
                    width: double.infinity,
                    height: screenWidth*0.13,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKeySignUp.currentState!.validate()) {
                            setState(() {
                              _isLoading = true; // Start loading
                            });
                            String? userToken = await userApi.createUser(
                                _nameController,
                                _emailController,
                                _phoneController);
                            setState(() {
                              _isLoading = false; // Stop loading
                            });
                            setToken(userToken!);
                            currentAuthState = AuthState.verify;
                          }
                        },
                        child: const Text('Continue')),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text('or continue with', style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Google', style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentAuthState = AuthState.login; // Switch to login
                              });
                            },
                            child: RichText(
                              text: TextSpan(
                                text:
                                'Already have an account?', // First part of the text
                                style: Theme.of(context).textTheme.bodyLarge,
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: ' LogIn',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );

      case AuthState.login:
        return SizedBox(
          key: const ValueKey<AuthState>(AuthState.login),
          child: Form(
            key: _formKeyLogin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign in into your\naccount',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Login to your account',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: screenHeight * 0.04),
                SizedBox(
                  height: screenHeight * 0.1,
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone number is required.';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: screenWidth * 0.13,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKeyLogin.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        String? userToken =
                        await userApi.getUser(_phoneController.text);
                        setState(() {
                          _isLoading = false;
                        });
                        setToken(userToken!);
                        currentAuthState = AuthState.verify;
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Center(
                    child: Column(
                      children: [
                        Text('or continue with', style: Theme.of(context).textTheme.bodyLarge),
                        SizedBox(height: screenHeight * 0.01),
                        Text('Google', style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentAuthState = AuthState.signup;
                    });
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: const [
                          TextSpan(
                              text: 'Signup',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      case AuthState.verify:
        return SizedBox(
          key: const ValueKey<AuthState>(AuthState.verify),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter OTP',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'We’ve sent an OTP to your email.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: screenHeight * 0.04),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      _resendTimer = 30;
                    });
                    startResendTimer();
                    await userApi.getUser(_phoneController.text);
                  },
                  child: Text(
                    _resendTimer > 0
                        ? 'Resend OTP in $_resendTimer seconds'
                        : 'Resend OTP',
                    style: TextStyle(
                      color: _resendTimer > 0
                          ? Colors.grey
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: _otpController,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 10,
                    fontSize: screenWidth*0.04,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              SizedBox(
                width: double.infinity,
                height: screenWidth * 0.13,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    String otp = _otpController.text.trim();
                    await userApi.verifyUser(userToken.value, otp);
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: const Text('Submit'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: Center(
                  child: Column(
                    children: [
                      Text('or continue with', style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: screenHeight * 0.01),
                      Text('Google', style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentAuthState = AuthState.signup;
                  });
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Don’t have an account? ',
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: const [
                        TextSpan(
                            text: 'Signup',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

}
