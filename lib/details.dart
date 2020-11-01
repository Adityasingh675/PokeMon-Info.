import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/pokemon.dart';

class Details extends StatelessWidget {
  final Pokemon pokemon;
  Details({this.pokemon});

  List <Widget> _prev = [
    Card(child: Text('This is the Base Form.', style: TextStyle(fontWeight: FontWeight.w500),),
    elevation: 0.0,
    )
  ];

  List <Widget> _next = [
    Card(child: Text('This is the most Advanced Form.', style: TextStyle(fontWeight: FontWeight.w500),),
    elevation: 0.0,
    ),
  ];

  bodyWidget(context) => Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 120.0),
                  Text(
                    pokemon.name,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text("Height: ${pokemon.height}"),
                  SizedBox(height: 5.0),
                  Text("Weight: ${pokemon.weight}"),
                  SizedBox(height: 10.0),
                  Text("Types", style: TextStyle(fontWeight: FontWeight.bold),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.type
                          .map(
                            (t) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: FilterChip(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    t,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {}),
                            ),
                          ).toList(),
                    ),
                  ),
                  Text("Weakness", style: TextStyle(fontWeight: FontWeight.bold)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.weaknesses
                          .map((w) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: FilterChip(
                                  backgroundColor: Colors.red,
                                  label: Text(w,
                                      style: TextStyle(color: Colors.white)),
                                  onSelected: (b) {},
                                ),
                          ))
                          .toList(),
                    ),
                  ),
                  Text("Previous Evolution", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height:5.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.prevEvolution == null ? _prev :pokemon.prevEvolution
                          .map((p) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: FilterChip(
                                  backgroundColor: Colors.blueGrey,
                                  label: Text(p.name,
                                      style: TextStyle(color: Colors.white)),
                                  onSelected: (b) {},
                                ),
                          )).toList(),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text("Next Evolution", style: TextStyle(fontWeight: FontWeight.bold)),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pokemon.nextEvolution == null ? _next :pokemon.nextEvolution
                            .map((n) => Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: FilterChip(
                                  backgroundColor: Colors.purple,
                                  label: Text(n.name,
                                      style: TextStyle(color: Colors.white)),
                                  onSelected: (b) {}),
                            )).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(pokemon.img)),
                ),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(pokemon.name),
      ),
      body: bodyWidget(context),
    );
  }
}
