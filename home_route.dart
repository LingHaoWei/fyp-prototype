// ignore_for_file: prefer_const_constructors

import 'package:final_year_project/auth/auth_page.dart';
import 'package:final_year_project/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthPage();
          }
        }
      ),
    );
  }
}