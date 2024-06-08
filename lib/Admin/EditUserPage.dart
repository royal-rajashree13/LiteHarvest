import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserPage extends StatefulWidget {
  final String userId;
  final String userName;
  final String userEmail;
  final String userPassword;

  const EditUserPage({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
  }) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.userEmail);
    _passwordController = TextEditingController(text: widget.userPassword);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void saveChanges() {
    String newName = _nameController.text.trim();
    String newEmail = _emailController.text.trim();
    String newPassword = _passwordController.text.trim();

    // Check if any field is empty
    if (newName.isEmpty || newEmail.isEmpty || newPassword.isEmpty) {
      // Show a snackbar or alert dialog to notify the user to fill all fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Update user details in Firestore using widget.userId
    FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'name': newName,
      'email': newEmail,
      'password': newPassword,
    }).then((_) {
      // Show a snackbar to indicate successful update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User details updated successfully.'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to the admin dashboard page
      Navigator.pop(context);
    }).catchError((error) {
      // Show a snackbar to indicate error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update user details: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
