import 'package:evently/firebase/firebase_manager.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = "SignupScreen";

  SignupScreen({super.key});

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final useNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final mainColor = const Color(0xFF5669FF); // اللون الأساسي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/images/logo_v.png",
                    height: 136,
                    width: 136,
                  ),
                  const SizedBox(height: 24),
                  buildTextField(
                    label: "Username",
                    controller: useNameController,
                    icon: Icons.person,
                    validator: (value) =>
                    value == null || value.isEmpty ? "Username is Required" : null,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: "Email",
                    controller: emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Email is Required";
                      final emailValid = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$",
                      ).hasMatch(value);
                      return emailValid ? null : "Email Not valid";
                    },
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: "Phone",
                    controller: phoneController,
                    icon: Icons.call,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Phone is Required";
                      return value.length == 11 ? null : "Phone Not valid";
                    },
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: "Password",
                    controller: passwordController,
                    icon: Icons.lock_open_outlined,
                    obscureText: true,
                    suffixIcon: Icons.remove_red_eye_rounded,
                    validator: (value) =>
                    value == null || value.isEmpty ? "Password is Required" : null,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: "RePassword",
                    controller: rePasswordController,
                    icon: Icons.lock_open_outlined,
                    obscureText: true,
                    suffixIcon: Icons.remove_red_eye_rounded,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "RePassword is Required";
                      return passwordController.text == value
                          ? null
                          : "Re Password is not match";
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseManager.signUp(
                          emailController.text,
                          passwordController.text,
                          phoneController.text,
                          useNameController.text,
                              () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.routeName,
                                  (route) => false,
                            );
                          },
                              (message) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Error"),
                                content: Text(message),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Okay"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "SignUp",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "I have an account! ",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pop(context),
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    IconData? suffixIcon,
    bool obscureText = false,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        labelStyle: TextStyle(color: Color(0xFF5669FF)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF5669FF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF5669FF)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
