// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, ' + user.email!),
              MaterialButton(
                onPressed: (){FirebaseAuth.instance.signOut();},
                color: Color(0xffA91D3A),
                child: Text(
                  'sign out',
                  style: TextStyle(
                    color: Color(0xffFDFDFD),
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