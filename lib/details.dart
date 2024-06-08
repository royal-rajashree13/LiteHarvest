import 'package:flutter/material.dart';
import 'organisation.dart';
import 'Instructions/home.dart';

class Details extends StatelessWidget{
  const Details ({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Details',
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
                  builder: (BuildContext context) => const Organisation(),
                ),
              );
            },
            child: const Text('Organisation'),
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
                  builder: (BuildContext context) => const House(),
                ),
              );
            },
            child: const Text('Instructions'),
          ),
        ],
      ),
    );
  }
  
}
