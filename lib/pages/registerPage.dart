import 'package:flutter/material.dart';
import 'package:releae/widgets/registerForm.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: const RegisterForm(),
          ),
        ),
      ),
    );
  }
}
