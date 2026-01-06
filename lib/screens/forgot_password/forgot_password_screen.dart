import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/forgot_pass_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text(
                  "Forgot\nPassword?",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Enter your email to receive an OTP\nand reset your password.",
                  style: TextStyle(
                    color: kSecondaryColor,
                  ),
                ),
                SizedBox(height: 40),
                ForgotPassForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
