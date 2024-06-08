import 'package:flutter/material.dart';
import 'package:lite_harvest/Admin/login.dart';
import 'package:lite_harvest/Management/UserProfilePage.dart';
// import 'package:lite_harvest/Management/login.dart';

class Organisation extends StatelessWidget{
  const Organisation ({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar( 
          title: Text('LiteHarvest'),
          backgroundColor: Colors.black,
          centerTitle: true,
          foregroundColor: Colors.white,   
        ),
    body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Organisation Login',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const UserProfilePage(),
                ),
              );
            },
            child: const Text('Management'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginAdmin(),
                ),
              );
            },
            child: const Text('Admin'),
          ),
        ],
      ),
    ),
    );
  }
}