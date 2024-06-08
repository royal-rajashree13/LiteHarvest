import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nutrient extends StatelessWidget {
  final List<Img> _imgs = [
    Img(img: 'assets/images/ph.jpeg'),
    Img(img: 'assets/images/nutrient.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('pH and Nutrients'),
        backgroundColor: Colors.black,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Expanded(
          child: GridView.builder(
              itemCount: _imgs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Image.asset(_imgs[index].img),
                );
              })),
    );
  }
}

class Img {
  final String img;

  Img({required this.img});
}
