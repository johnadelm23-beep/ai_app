import 'package:ai_app/ai_app.dart';
import 'package:ai_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(AiApp());
}
// command link project with firebase console dart pub global run flutterfire_cli:flutterfire configure --project=ai-app-8e111;