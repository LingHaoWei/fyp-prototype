// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage,});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  final _emailController = TextEditingController(); 
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  //final int _userIDController = 1;
  final _usernameController = TextEditingController();
  final _preferFileTypeController = TextEditingController();

  final List<String> _dropDownItems = ['mp3', 'flac'];
  String _selectedItem = 'mp3';


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _usernameController.dispose();
    _preferFileTypeController.dispose();
    super.dispose();
  }

  Future signUp() async {
    
    if (passwordConfirmed() && validate()) {
      try {
        // store user details
        storeUserDetails(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _usernameController.text.trim(),
          _preferFileTypeController.text.trim(),
        );
        //create user account
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(), 
          password: _passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
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
  }

  Future storeUserDetails(String email, String password, String username, String preferfile) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'email': email,
        'password': password,
        'username': username,
        'preferfile': preferfile,
      });
    } on FirebaseException catch (e) {
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

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _passwordConfirmController.text.trim()) {
      return true;
    } else {
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text('Password does not match!'),
          );
        },
      );
      return false;
    }
  }

  bool validate() {
    if (_usernameController.text.trim() == '' || _preferFileTypeController == '') {
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text('Username and prefer file type are reuqired!'),
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151515),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.android,
                  size: 100,
                  color: Color(0xffFDFDFD),
                ),
            
                Text(
                  "NEW USER",
                  style: TextStyle(
                    color: Color(0xffFDFDFD),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 50),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xffFDFDFD)),
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
                SizedBox(height: 15),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xffFDFDFD)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(
                          color: Color(0xffFDFDFD),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color(0xffEEEEEE),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xffFDFDFD)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        style: TextStyle(
                          color: Color(0xffFDFDFD),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            color: Color(0xffEEEEEE),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xffFDFDFD)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _usernameController,
                        style: TextStyle(
                          color: Color(0xffFDFDFD),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Color(0xffEEEEEE),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xffFDFDFD)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DropdownButtonFormField(
                        value: _selectedItem,
                        focusColor: Color(0xff151515),
                        dropdownColor: Color(0xff151515),
                        style: TextStyle(
                          color: Color(0xffFDFDFD),
                        ),
                        items: _dropDownItems.map((String item){
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedItem = value!;
                          });
                        },
                      ),
                      
                      /*TextField(
                        controller: _preferFileTypeController,
                        style: TextStyle(
                          color: Color(0xffFDFDFD),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'mp3',
                          hintStyle: TextStyle(
                            color: Color(0xffEEEEEE),
                            fontSize: 14,
                          ),
                        ),
                      ),*/

                    ),
                  ),
                ),
                SizedBox(height: 50),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xffA91D3A),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xffFDFDFD),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            
                SizedBox(height: 20),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Color(0xffFDFDFD),
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xffFDFDFD),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}