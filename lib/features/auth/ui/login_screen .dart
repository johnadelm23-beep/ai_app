import 'package:ai_app/core/validator/app_validation.dart';
import 'package:ai_app/core/widgets/custom_app_button.dart';
import 'package:ai_app/core/widgets/custom_text_foem_field.dart';
import 'package:ai_app/features/auth/cubit/auth_cubit.dart';
import 'package:ai_app/features/auth/ui/register_screen.dart';
import 'package:ai_app/features/chat/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      context.read<AuthCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  Widget _buildUI(bool isLoading) {
    return Column(
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
                controller: _emailController,
                validator: AppValidator.email,
              ),

              const SizedBox(height: 12),

              CustomTextFoemField(
                text: "Password",
                obscureText: true,
                controller: _passwordController,
                validator: AppValidator.loginPassword,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomAppButton(
                  text: 'Login',
                  onPressed: isLoading ? null : _login,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        InkWell(
          onTap: isLoading
              ? null
              : () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const RegisterScreen(),
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

        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
