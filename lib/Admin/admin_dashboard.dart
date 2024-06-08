// EMAIL: adminliteharvest@gmail.com
// PASSWORD: liteharvest@admin

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lite_harvest/Admin/login.dart';
import 'AddUserPage.dart'; // Import AddUserPage
import 'EditUserPage.dart'; // Import EditUserPage

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  late Stream<QuerySnapshot> _usersStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Initialize the stream to get real-time updates of user data
    _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  // Function to delete a user document from Firestore
  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  // Function to navigate to EditUserPage for updating user details
  void navigateToEditUserPage(
      String userId, String userName, String userEmail, String userPassword) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserPage(
          userId: userId,
          userName: userName,
          userEmail: userEmail,
          userPassword: userPassword,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard',),
        backgroundColor: Colors.black, // Black background color
        centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginAdmin()), // Redirect to login page
                    );
                 }, 
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index].data() as Map<String, dynamic>;
              final userId = users[index].id;
              final userName = userData['name'];
              final userEmail = userData['email'];
              final userPassword = userData['password'];

              return ListTile(
                title: Text(userName ?? ''),
                subtitle: Text(userEmail ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navigate to EditUserPage for updating user details
                        navigateToEditUserPage(userId, userName ?? '',
                            userEmail ?? '', userPassword ?? '');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Delete the user and update UI
                        deleteUser(userId);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserPage()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: Text(
              'Add User',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
      ),
    );
  }
}
