import 'package:ai_app/features/auth/ui/login_screen%20.dart';
import 'package:flutter/material.dart';

class AiApp extends StatelessWidget {
  const AiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "appFont"),
      home: LoginScreen(),
    );
  }
}
