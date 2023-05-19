import 'package:flutter/material.dart';
import 'package:flutter_list_times/pages/login_page.dart';
import 'package:flutter_list_times/pages/registrar_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScrennsLoginRegister() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScrennsLoginRegister);
    } else {
      return RegistrarPage(showLoginPage: toggleScrennsLoginRegister);
    }
  }
}
