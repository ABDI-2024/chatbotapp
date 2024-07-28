// ignore_for_file: prefer_const_constructors

import 'package:chatbotapp/Auth_page.dart';
import 'package:chatbotapp/pages/chatpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
