import 'package:biomob/screens/home_screen.dart';
import 'package:biomob/screens/login_screen.dart';
import 'package:biomob/screens/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Biomob());
}

class Biomob extends StatelessWidget {
  const Biomob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
