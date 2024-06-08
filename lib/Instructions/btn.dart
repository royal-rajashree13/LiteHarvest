import 'package:flutter/material.dart';
import 'Steps/step1.dart';
import 'Steps/step2.dart';
import 'Steps/step3.dart';
import 'Steps/nutrient.dart';

class Btn extends StatelessWidget{
  const Btn({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 60)),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Step1()
                )
              );
            }, 
            child: Text(
              "Step 1 : Prepare The Setup",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            ),
            style: ElevatedButton.styleFrom(fixedSize: const Size(450, 50)),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => Step2()
                )
              );
            }, 
            child: Text(
              "Step 2 : Germinate Seeds",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            ),
            style: ElevatedButton.styleFrom(fixedSize: const Size(450, 50)),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => Step3()
                )
              );
            }, 
            child: Text(
              "Step 3 : Final Setup",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            ),
            style: ElevatedButton.styleFrom(fixedSize: const Size(450, 50)),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => Nutrient()
                )
              );
            }, 
            child: Text(
              "pH and Nutrients",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            ),
            style: ElevatedButton.styleFrom(fixedSize: const Size(450, 50)),
          ),
        ],
      ),
    );
  }

  
}