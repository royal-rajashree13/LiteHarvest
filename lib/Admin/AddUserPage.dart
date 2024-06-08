import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // final CollectionReference _userCollection =
  //     FirebaseFirestore.instance.collection('users');

  Future<void> addUser() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
        addUserData(userCredential.user!.uid, name, email,password);
        // await _userCollection.doc().set({
        //   'name': name,
        //   'email': email,
        //   'password': password,
        // });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('User added successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pop(context); // Close the AddUserPage
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        print('Error adding user: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add user. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
Future<void> addUserData(String uid, String name, String email, String password) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
        backgroundColor: Colors.black,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addUser,
                child: Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
