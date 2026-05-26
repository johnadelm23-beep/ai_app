import 'package:ai_app/features/auth/cubit/auth_cubit.dart';
import 'package:ai_app/features/auth/ui/login_screen%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiApp extends StatelessWidget {
  const AiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "appFont"),
        home: LoginScreen(),
      ),
    );
  }
}
