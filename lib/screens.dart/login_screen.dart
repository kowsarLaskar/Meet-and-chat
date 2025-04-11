import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/utils/utils_snackbar.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  void signInWithGoogle(BuildContext context) async {
    bool res = await _authMethods.signInWithGoogle(context);

    if (res && context.mounted) {
      Navigator.pushNamed(context, '/Home'); // ✅ Safe navigation
    } else if (context.mounted) {
      showSnackBar(context, "Sign-in failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Start or join a meeting',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45.0),
            child: Image.asset('assets/images/onboarding.jpg'),
          ),
          CustomButton(
            onPressed: () {
              signInWithGoogle(context);
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
