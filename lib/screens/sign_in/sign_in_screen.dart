import 'package:flutter/material.dart';

import '../../components/no_account_text.dart';
import 'components/sign_form.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});

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
                SizedBox(height: 60),
                Text(
                  "Welcome\nBack!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 40),
                SignForm(),
                SizedBox(height: 40),
                Center(
                  child: NoAccountText(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
