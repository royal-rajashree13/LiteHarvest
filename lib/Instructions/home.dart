import 'package:flutter/material.dart';
import 'select.dart';
import 'btn.dart';

class House extends StatelessWidget{
  const House ({Key? key}) : super(key: key);
  
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
        body: Column( 
          children: [
            Select(),
            Btn(),
          ],
        ),
    );
  }
  
}