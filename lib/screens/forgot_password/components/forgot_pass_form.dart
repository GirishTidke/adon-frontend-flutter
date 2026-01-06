import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../features/auth/auth_service.dart';
import '../../sign_in/sign_in_screen.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? otp;
  String? password;

  bool otpSent = false;
  bool obscurePassword = true;
  bool isLoading = false;

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
    bool enabled = true,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: enabled ? Colors.white : Colors.grey.shade100,
      border: outlineInputBorder(),
      enabledBorder: outlineInputBorder(),
      focusedBorder: outlineInputBorder(),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Password Reset Successful 🎉",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Your password has been updated.\nPlease login with your new password.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(
                context,
                SignInScreen.routeName,
              );
            },
            child: const Text(
              "Login",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// EMAIL
          TextFormField(
            enabled: !otpSent,
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration(
              hint: "Email",
              icon: Icons.email_outlined,
              enabled: !otpSent,
            ),
            validator: (v) =>
                v == null || !emailValidatorRegExp.hasMatch(v) ? "" : null,
            onSaved: (v) => email = v,
          ),

          if (otpSent) ...[
            const SizedBox(height: 20),

            /// OTP
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: _inputDecoration(
                hint: "OTP",
                icon: Icons.lock_clock_outlined,
              ),
              validator: (v) => v == null || v.length != 6 ? "" : null,
              onSaved: (v) => otp = v,
            ),

            const SizedBox(height: 20),

            /// NEW PASSWORD
            TextFormField(
              obscureText: obscurePassword,
              decoration: _inputDecoration(
                hint: "New Password",
                icon: Icons.lock_outline,
                suffix: IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
              validator: (v) => v == null || v.length < 8 ? "" : null,
              onSaved: (v) => password = v,
            ),
          ],

          const SizedBox(height: 30),

          /// BUTTON
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: isLoading
                  ? null
                  : () async {
                      if (!_formKey.currentState!.validate()) return;

                      _formKey.currentState!.save();
                      setState(() => isLoading = true);

                      if (!otpSent) {
                        final success =
                            await AuthService.forgotPassword(email!);

                        setState(() => isLoading = false);

                        if (success) {
                          setState(() => otpSent = true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("OTP sent to your email"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Failed to send OTP"),
                            ),
                          );
                        }
                      } else {
                        final success = await AuthService.resetPassword(
                          email: email!,
                          otp: otp!,
                          password: password!,
                        );

                        setState(() => isLoading = false);

                        if (success) {
                          _showSuccessDialog();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Invalid OTP or error"),
                            ),
                          );
                        }
                      }
                    },
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      otpSent ? "Reset Password" : "Send OTP",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
