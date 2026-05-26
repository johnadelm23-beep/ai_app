import 'package:ai_app/core/validator/app_validation.dart';
import 'package:ai_app/core/widgets/custom_app_button.dart';
import 'package:ai_app/core/widgets/custom_text_foem_field.dart';
import 'package:ai_app/features/auth/ui/login_screen%20.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Create account and Joy With ",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    TextSpan(
                      text: "Janjony",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: .bold,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),

              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFoemField(
                          text: "Name",
                          controller: _nameController,
                          validator: (v) => AppValidator.name(v),
                        ),

                        const SizedBox(height: 15),

                        CustomTextFoemField(
                          text: "Email",
                          controller: _emailController,
                          validator: (v) => AppValidator.email(v),
                        ),

                        const SizedBox(height: 15),

                        CustomTextFoemField(
                          text: "Password",
                          obscureText: true,
                          controller: _passwordController,
                          validator: (v) => AppValidator.password(v),
                        ),

                        const SizedBox(height: 15),

                        CustomTextFoemField(
                          text: "Confirm password",
                          obscureText: true,
                          controller: _confirmPasswordController,
                          validator: (v) => AppValidator.confirmPassword(
                            v,
                            _passwordController.text,
                          ),
                        ),

                        const SizedBox(height: 100),

                        CustomAppButton(
                          text: "Register",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.only(bottom: keyboardHeight > 0 ? 10 : 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Have an account? ",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        TextSpan(
                          text: "Sign In",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
