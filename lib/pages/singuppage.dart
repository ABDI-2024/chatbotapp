// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Singup extends StatefulWidget {
  final VoidCallback showLoginPage;
  const Singup({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  // text controller
  final _emailcontro = TextEditingController();
  final _passcontro = TextEditingController();
  final _Cpasscontro = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  String passwordNotMatch = '';

  @override
  void dispose() {
    _emailcontro.dispose();
    _passcontro.dispose();
    _Cpasscontro.dispose();
    super.dispose();
  }

  Future singUp() async {
    if (_key.currentState!.validate()) {
      if (Passconfirmed()) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailcontro.text.trim(),
            password: _passcontro.text.trim(),
          );
        } on FirebaseAuthException catch (error) {
          errorMessage = error.message!;
        }
        setState(() {});
      }
    }
  }

  Passconfirmed() {
    if (_passcontro.text.trim() == _Cpasscontro.text.trim()) {
      return true;
    } else {
      setState(() {
        passwordNotMatch = 'Password not match';
      });
    }
  }

  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      size: 100,
                    ),
                    Text(
                      'Mobile ChatBot App',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text('for internship students'),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight: Radius.circular(80)),
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Form(
                                key: _key,
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40),
                                    ),
                                    SizedBox(height: 25),
                                    TextFormField(
                                      controller: _emailcontro,
                                      validator: validateEmail,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        hintText: 'Email',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        errorMessage,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _passcontro,
                                      obscureText: passwordVisible,
                                      validator: validatePassword,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible =
                                                  !passwordVisible;
                                            });
                                          },
                                        ),
                                        prefixIcon: Icon(Icons.password),
                                        hintText: 'Password',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _Cpasscontro,
                                      obscureText: passwordVisible,
                                      validator: validatePassword,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible =
                                                  !passwordVisible;
                                            });
                                          },
                                        ),
                                        prefixIcon: Icon(Icons.password),
                                        hintText: 'Confirm Password',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      passwordNotMatch,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: singUp,
                                      child: Container(
                                        color: Colors.black,
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 150,
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'I am a Member?',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: widget.showLoginPage,
                                  child: Text(
                                    ' Login In',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            //
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    // ignore: curly_braces_in_flow_control_structures
    return 'E-mail address is required.';
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    // ignore: curly_braces_in_flow_control_structures
    return 'Password is required.';
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return '''
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      ''';
  }
  return null;
}
