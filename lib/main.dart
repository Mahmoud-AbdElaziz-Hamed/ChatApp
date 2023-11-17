import 'package:chatapp/screens/chat.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Login': (context) => Login(),
        'Register': (context) => const Register(),
        'chat': (context) => Chat(),

        // 'Welcome': (context) => Welcome(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: "Login",
    );
  }
}
