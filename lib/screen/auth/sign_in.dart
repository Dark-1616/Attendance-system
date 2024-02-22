import 'package:attendance_system/firebase-auth/firebase-auth.dart';
import 'package:attendance_system/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/constant/buttons.dart';
import '../../components/colors.dart';
import '../../components/constant/size.dart';
import '../../components/image.dart';
import '../../components/input_button.dart';
import '../home_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _matriculeController = TextEditingController();

  bool isSigningUp = false;

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
      body: Stack(
        children: [
          Positioned(
              left: 105,
              child: Container(
                child:
                    ImageWidget(width: 326, heigth: 281, image: 'background2'),
              )),
          Positioned(
              top: 530,
              right: 130,
              child: ImageWidget(width: 320, heigth: 174, image: 'background')),
          Center(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: pagelength(context: context, value: 70)),
                    child: ImageWidget(
                      image: 'schoologo',
                      heigth: 80,
                      width: 80,
                    )),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Appcolors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 30),
                inputButton(
                  context: context,
                  label: 'Name',
                  controller: _usernameController,
                ),
                const SizedBox(height: 20),
                inputButton(
                  context: context,
                  label: 'Matricule',
                  controller: _matriculeController,
                ),
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
                const SizedBox(height: 40),
                buttonWidget(
                    action: () => _signUp(),
                    radius: 10,
                    length: 50,
                    width: 357,
                    child: Center(
                      child: isSigningUp
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('Sign in',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20)),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String matricule = _matriculeController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      messagePopup(message: "User is successfully created");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      messagePopup(message: "Some error happend");
    }
  }
}
