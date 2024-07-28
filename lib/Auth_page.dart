import 'package:chatbotapp/pages/loginpage.dart';
import 'package:chatbotapp/pages/singuppage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // show the login page
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return loginpage(showRegisterPage: toggleScreen);
    } else {
      return Singup(showLoginPage: toggleScreen);
    }
  }
}
