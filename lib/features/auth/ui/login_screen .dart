import 'package:ai_app/core/validator/app_validation.dart';
import 'package:ai_app/core/widgets/custom_app_button.dart';
import 'package:ai_app/core/widgets/custom_text_foem_field.dart';
import 'package:ai_app/features/auth/ui/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              const Text(
                "Chat Janjony",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFoemField(
                      text: 'Email',
                      validator: (v) => AppValidator.email(v),
                    ),
                    SizedBox(height: 12),
                    CustomTextFoemField(
                      text: "Password",
                      obscureText: true,
                      validator: (v) => AppValidator.loginPassword(v),
                    ),

                    const SizedBox(height: 30),

                    CustomAppButton(text: 'Login', onPressed: () {}),
                  ],
                ),
              ),

              const Spacer(),

              AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.only(bottom: keyboardHeight > 0 ? 10 : 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const RegisterScreen(),
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
                          text: "Don't have an account? ",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        TextSpan(
                          text: "Sign Up",
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
