import 'package:ai_app/core/validator/app_validation.dart';
import 'package:ai_app/core/widgets/custom_app_button.dart';
import 'package:ai_app/core/widgets/custom_text_foem_field.dart';
import 'package:ai_app/features/auth/cubit/auth_cubit.dart';
import 'package:ai_app/features/auth/ui/login_screen%20.dart';
import 'package:ai_app/features/chat/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _register() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      context.read<AuthCubit>().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  Widget _buildUI(bool isLoading) {
    return Column(
      children: [
        const SizedBox(height: 20),

        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Create account and Join ",
                style: TextStyle(fontSize: 28),
              ),
              TextSpan(
                text: "Janjony",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),

        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFoemField(
                    text: "Name",
                    controller: _nameController,
                    validator: AppValidator.name,
                  ),

                  const SizedBox(height: 15),

                  CustomTextFoemField(
                    text: "Email",
                    controller: _emailController,
                    validator: AppValidator.email,
                  ),

                  const SizedBox(height: 15),

                  CustomTextFoemField(
                    text: "Password",
                    obscureText: true,
                    controller: _passwordController,
                    validator: AppValidator.password,
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

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomAppButton(
                      text: "Register",
                      onPressed: isLoading ? null : _register,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        InkWell(
          onTap: isLoading
              ? null
              : () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginScreen(),
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
          child: const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.amber,
                      fontWeight: .bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }

            if (state is AuthSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ChatScreen(),
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
                (route) => false,
              );
            }
          },

          builder: (context, state) {
            final isLoading = state is AuthLoadingState;

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildUI(isLoading),
                ),

                // 🔥 DARK LOADING OVERLAY
                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.6),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
