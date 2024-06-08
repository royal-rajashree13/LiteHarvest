import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'admin_dashboard.dart'; // Import the AdminDashboardPage

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to admin dashboard page on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboardPage()),
      );
    } catch (e) {
      // Handle login errors here
      print("Login error: $e");
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in. Please check your credentials.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          title: Text('Admin Login'),
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
