import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../tile.dart';

class Step1 extends StatelessWidget{
  final List<Tile> tiles = [
    Tile(name: 'Use any plastic bottle to make the container for holding the plants.',img: 'assets/images/bottle.jpeg'),
    Tile(name: 'Cut the plastic bottle into two halves.',img: 'assets/images/cutBottle.jpg'),
    Tile(name: 'Make small holes on the bottle cap.',img: 'assets/images/capholes.jpg'),
    Tile(name: 'Insert the wick through the holes made on the bottle cap until it comes out from the other end of the cut bottle and close the cap.',img: 'assets/images/wickCap.jpeg'),
    Tile(name: 'The basic setup is ready',img: 'assets/images/bottle.jpeg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar( 
          title: Text('Step 1 : Prepare The Setup'),
          backgroundColor: Colors.black,
          centerTitle: true,
          foregroundColor: Colors.white,   
        ),
      body:ListView.builder(
            itemCount: tiles.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:1.0,horizontal: 4.0 ),
                child: Card(
                  child: ListTile(
                    title: Text(tiles[index].name),
                    visualDensity: VisualDensity(vertical: 4),
                    trailing: Image.asset(tiles[index].img),
                  ),
              ),
              );
            })
    );
  }
}
