import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './UserProfilePage.dart';

class LoginManage extends StatefulWidget {
  const LoginManage({Key? key}) : super(key: key);

  @override
  _LoginManageState createState() => _LoginManageState();
}

class _LoginManageState extends State<LoginManage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      // Query Firestore to check if the user with the provided email exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User with provided email found, check if password matches
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        String storedPassword = userSnapshot['password'];
        // String userName = userSnapshot['name']; // Retrieve user's name

        if (storedPassword == password) {
          await _auth.signInWithEmailAndPassword(
        email: email, password: password);
          // Passwords match, navigate to new page and pass user's name
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfilePage(),
            ),
          );
        } else {
          // Passwords don't match, show error message
          _showSnackBar('Incorrect password. Please try again.');
        }
      } else {
        // User with provided email not found, show error message
        _showSnackBar('User with this email does not exist.');
      }
    } catch (e) {
      // Handle errors
      print('Login error: $e');
      _showSnackBar('An error occurred. Please try again later.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Management Login'),
          backgroundColor: Colors.black,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    onPressed: login,
                    child: Text('Login'),
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