// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim()
      );
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text('Password reset link sent! Check your email.'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      //print(e);
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff151515),
        elevation: 0,
        foregroundColor: Color(0xffFDFDFD),
      ),
      backgroundColor: Color(0xff151515),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Text(
                  'Enter Your Email and we will send you a password reset link.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffFDFDFD),
                  ),
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Color(0xffFDFDFD),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(
                        color: Color(0xffFDFDFD),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Color(0xffEEEEEE),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              MaterialButton(
                onPressed: passwordReset,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Color(0xffFDFDFD),
                    ),
                  ),
                ),
                color: Color(0xffA91D3A),
              ),
            ],
          ),
        ),
      ),
    );
  }
}