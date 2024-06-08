import 'package:flutter/material.dart';

class Select extends StatelessWidget{
  const Select ({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Steps for Setup",
        style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
      ),
    );
  }
  
}