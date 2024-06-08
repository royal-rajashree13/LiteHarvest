import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../tile.dart';

class Step2 extends StatelessWidget{
  final List<Tile> tiles = [
    Tile(name: 'Soak seeds in water for 1hr to ensure they are hydrated, giving them the best chance for germination.',img: 'assets/images/soakSeeds.jpeg'),
    Tile(name: 'Plant the Seeds: Sow one seed in each medium, no deeper than 1cm.',img: 'assets/images/plantSeeds.jpeg'),
    Tile(name: 'Cover your seedlings with a dome or plastic kitchen wrap to create the perfect microclimate for germinating seeds..',img: 'assets/images/coverSeeds.jpeg'),
    Tile(name: 'Maintain and monitor the temperature.',img: 'assets/images/coverSeeds.jpeg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar( 
          title: Text('Step 2 : Germinate Seeds'),
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
