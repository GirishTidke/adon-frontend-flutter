import 'package:flutter/material.dart';

import '../../constants.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Create\nAccount",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 40),
                const SignUpForm(),
                const SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SignInScreen.routeName,
                      );
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
