import 'package:flutter/material.dart';
import 'package:purotaja/utils/auth_service.dart';
import 'package:purotaja/utils/toast_message.dart';

enum AuthState { login, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  AuthState currentAuthState = AuthState.signup;
  AuthService authService = AuthService();
  late bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                      transitionBuilder: (Widget child, Animation<double> animation) {
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
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.00),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true; // Start loading
                        });
                        await authService.signUp(_nameController, _emailController);
                        setState(() {
                          _isLoading = false; // Start loading
                        });
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
        );

      case AuthState.login:
        return SizedBox(
          key: const ValueKey<AuthState>(AuthState.login),
          height: 650,
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
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child:
                    ElevatedButton(onPressed: () async {
                      setState(() {
                        _isLoading = true; // Start loading
                      });
                      String response = await authService.logIn(_emailController);
                      showToast(response);
                      setState(() {
                        _isLoading = false; // Start loading
                      });
                    }, child: const Text('Login')),
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
              )
            ],
          ),
        );

      // Default case to handle unexpected values
      default:
        return const SizedBox
            .shrink(); // Empty widget if no valid state is found
    }
  }
}
