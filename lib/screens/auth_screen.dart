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
    return Scaffold(
      body: Stack(
        children: [
          TopBanner(),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // The image of the logo
                    Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: Image.asset('assets/purotaja_logo.png'),
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
                    )
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
    switch (currentAuthState) {
      case AuthState.signup:
        return SizedBox(
          key: const ValueKey<AuthState>(AuthState.signup),
          height: 650,
          child: Form(
            key: _formKeySignUp,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create a New \nAccount',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create an account and get started',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 20),
                // Asking for name from the user
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
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
                    return null; // No validation error
                  },
                ),
                const SizedBox(height: 10),
                // Asking for email from the user
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required.';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address.';
                    }
                    return null; // No validation error
                  },
                ),
                const SizedBox(height: 10),
                // Asking for phone number from the user
                TextFormField(
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
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
                const SizedBox(height: 10),
                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.00),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
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
                              _isLoading = false; // Start loading
                            });
                            setToken(userToken!);
                            currentAuthState = AuthState.verify;
                          }
                        },
                        child: const Text('Continue')),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text('or continue with'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Google'),
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
                            'Already have an account?? ', // First part of the text
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium, // Style for the first part
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'LogIn',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );

      case AuthState.login:
        return SizedBox(
          key: const ValueKey<AuthState>(AuthState.login),
          height: 650,
          child: Form(
            key: _formKeyLogin,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign in into your\naccount',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login to your account',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 20),
                // Asking for Phone number
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return('Phone number is required.');
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value!)) {
                      return('Enter a valid 10-digit phone number.');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        if(_formKeyLogin.currentState!.validate()){
                          setState(() {
                            _isLoading = true; // Start loading
                          });
                          String? userToken =
                          await userApi.getUser(_phoneController.text);
                          setState(() {
                            _isLoading = false; // Start loading
                          });
                          setToken(userToken!);
                          currentAuthState = AuthState.verify;
                        }
                      },
                      child: const Text('Login')),
                ),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text('or continue with'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Google'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentAuthState = AuthState.signup; // Switch to signup
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                        text:
                            'Don’t have an account? ', // First part of the text
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium, // Style for the first part
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Signup',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );

      case AuthState.verify:
        return SizedBox(
          key: const ValueKey<AuthState>(AuthState.verify),
          height: 650,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter OTP',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'We’ve sent an OTP to your email.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 20),
              // Resend OTP Timer
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
              const SizedBox(height: 10),
              // OTP Input Field
              TextFormField(
                controller: _otpController,
                maxLength: 6, // Set length to 4 for OTP
                textAlign: TextAlign.center,
                style: const TextStyle(
                  letterSpacing: 10, // Space between digits
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  counterText: '', // Remove character counter
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true; // Start loading
                    });
                    String otp =
                        _otpController.text.trim(); // Get OTP from controller
                    await userApi.verifyUser(userToken.value, otp);
                    setState(() {
                      _isLoading = false; // Stop loading
                    });
                  },
                  child: const Text('Submit'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('or continue with'),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Google'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentAuthState = AuthState.signup; // Switch to signup
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Don’t have an account? ', // First part of the text
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium, // Style for the first part
                      children: const <TextSpan>[
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
        return const SizedBox
            .shrink();
    }
  }
}
