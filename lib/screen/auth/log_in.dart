import 'package:attendance_system/components/constant/buttons.dart';
import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/constant/size.dart';
import 'package:attendance_system/components/dashboard_input_component.dart';
import 'package:attendance_system/components/image.dart';
import 'package:attendance_system/firebase-auth/firebase-auth.dart';
import 'package:attendance_system/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/input_button.dart';
import '../home_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  void _onButtonPressed() {
    print('pressed');
  }

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _matriculeController = TextEditingController();

  bool isSigningIn = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _matriculeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Positioned(
                  left: 105,
                  child: Container(
                    child: ImageWidget(
                        width: 326, heigth: 281, image: 'background2'),
                  )),
              Positioned(
                  bottom: 0,
                  right: 130,
                  child: ImageWidget(
                      width: 320, heigth: 174, image: 'background')),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Padding(
                        padding: EdgeInsets.only(
                            //left: pagewidth(context: context, value: 65),
                            top: pagelength(context: context, value: 70)),
                        child: ImageWidget(
                          image: 'schoologo',
                          heigth: 80,
                          width: 80,
                        )),
                    heightSpace(20),
                    const Center(
                      child: Text(
                        'log in',
                        style: TextStyle(
                            color: Appcolors.yellow,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    // const Center(
                    //   child: Text(
                    //     ' here to continue',
                    //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                    // const SizedBox(height: 30),
                    // inputButton(
                    //   context: context,
                    //   label: 'Name',
                    //   controller: _usernameController,
                    // ),
                    const SizedBox(height: 20),
                    inputButton(
                      context: context,
                      label: 'Email',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20),
                    inputButton(
                      context: context,
                      label: 'Password',
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 60),
                    buttonWidget(
                        action: () => _signIn(),
                        radius: 10,
                        length: 50,
                        width: 350,
                        child: Center(
                          child: isSigningIn
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('log in',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20)),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'create a new account',
                      style: TextStyle(
                          fontSize: 14,
                          color: Appcolors.black,
                          decoration: TextDecoration.underline),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _signIn() async {
    Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    // setState(() {
    //   isSigningIn = true;
    // });

    // // String username = _usernameController.text;
    // String email = 'you@gmail.com';
    // String password = '123456';
    // // String email = _emailController.text;
    // // String password = _passwordController.text;
    // // String matricule = _matriculeController.text;

    // User? user = await _auth.signInWithEmailAndPassword(
    //   email,
    //   password,
    // );

    // setState(() {
    //   isSigningIn = false;
    // });
    // if (user != null) {
    //   messagePopup(message: "User is successfully Signedin");
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => HomePage()));
    // } else {
    //   messagePopup(message: "Some error happend");
    // }
  }
}
