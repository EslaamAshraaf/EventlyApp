import 'package:evently/firebase/firebase_manager.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:evently/screens/register/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";

  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static const Color highlightColor = Color(0xFF5669FF);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Center(
                child: Image.asset(
                  "assets/images/logo_v.png",
                  height: 136,
                  width: 136,
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(
                context: context,
                controller: emailController,
                label: "Email",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context: context,
                controller: passwordController,
                label: "Password",
                icon: Icons.lock_open_outlined,
                obscureText: true,
                suffixIcon: const Icon(Icons.remove_red_eye_rounded),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forget Password?",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: highlightColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  FirebaseManager.login(
                    emailController.text.trim(),
                    passwordController.text,
                        () {
                      appProvider.initUser();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeScreen.routeName,
                            (route) => false,
                      );
                    },
                        (message) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(message),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Okay"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: highlightColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Login",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Create Account",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: highlightColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, SignupScreen.routeName);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),
        prefixIcon: Icon(icon, color: highlightColor),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: highlightColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: highlightColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
