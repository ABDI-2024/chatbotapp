// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:chatbotapp/pages/helppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const loginpage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  Future singIn() async {
    if (_key.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorMessage = 'the email is not registred';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'the password is wrong';
        } else {
          errorMessage = e.message!;
        }
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                                      'Login',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40),
                                    ),
                                    SizedBox(height: 25),
                                    TextFormField(
                                      controller: _emailController,
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
                                      controller: _passwordController,
                                      obscureText: passwordVisible,

                                      // validator: validatePassword,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: singIn,
                                          child: Container(
                                            color: Colors.black,
                                            alignment: Alignment.center,
                                            height: 40,
                                            width: 150,
                                            child: Text(
                                              'Log In',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   // onTap: () {
                                        //   //   Navigator.push(
                                        //   //     context,
                                        //   //     MaterialPageRoute(
                                        //   //       builder: (context) => Singup(),
                                        //   //     ),
                                        //   //   );
                                        //   // },
                                        //   child: Container(
                                        //     color: Colors.black,
                                        //     alignment: Alignment.center,
                                        //     height: 40,
                                        //     width: 150,
                                        //     child: Text(
                                        //       'Sign Up',
                                        //       style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontWeight: FontWeight.normal,
                                        //           fontSize: 15),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
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
                                  'Not a member?',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: widget.showRegisterPage,
                                  child: Text(
                                    ' Regiter now',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     GestureDetector(
                            //       onTap: () {
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) => helppage(),
                            //           ),
                            //         );
                            //       },
                            //       child: Container(
                            //           alignment: Alignment.center,
                            //           // color: Colors.grey,
                            //           height: 40,
                            //           width: 100,
                            //           child: Text(
                            //             "NEED HELP??",
                            //             style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontWeight: FontWeight.bold),
                            //           )),
                            //     ),
                            //   ],
                            // )

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
    return 'E-mail address is required.';
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
  return null;
}

// String? validatePassword(String? formPassword) {
//   if (formPassword == null || formPassword.isEmpty)
//     return 'Password is required.';
//   String pattern =
//       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
//   RegExp regex = RegExp(pattern);
//   if (!regex.hasMatch(formPassword)) {
//     return '''
//       Password must be at least 8 characters,
//       include an uppercase letter, number and symbol.
//       ''';
//   }
//   return null;
// }
