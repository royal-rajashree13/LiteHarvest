import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../tile.dart';

class Step3 extends StatelessWidget{
  final List<Tile> tiles = [
    Tile(name: 'Place the growing media in the top portion of the bottle being sure to hold onto the wick so it spread the height of the top portion of the bottle.',img: 'assets/images/growMedia.jpeg'),
    Tile(name: 'Check and mark how high you want the water, the wick must be submerged. Add the water to your mark. ',img: 'assets/images/waterMark.jpeg'),
    Tile(name: 'Place the top portion back onto the bottom portion.',img: 'assets/images/topBottom.jpeg'),
    Tile(name: 'The hydroponics setup is ready.',img: 'assets/images/system.jpeg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar( 
          title: Text('Step 3 : Final Setup'),
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
