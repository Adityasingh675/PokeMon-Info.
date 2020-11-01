import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/details.dart';
import 'dart:convert';
import 'package:pokemon_app/pokemon.dart';

void main() => runApp(MaterialApp(
  title: "Pokemon Info.",
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeDictionary pokeDictionary;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async{
    http.Response response = await http.get(url);
    var decodedJson = json.decode(response.body);
    pokeDictionary = PokeDictionary.fromJson(decodedJson);
    setState(() {});
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon Info"),
        backgroundColor: Colors.cyan,
      ),
      body: pokeDictionary == null ? Center(child: CircularProgressIndicator(),) : LandingPage(pokeDictionary: pokeDictionary),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {fetchData();});
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh)
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({
    Key key,
    @required this.pokeDictionary,
  }) : super(key: key);

  final PokeDictionary pokeDictionary;

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2,
    children:
      pokeDictionary.pokemon.map((poke) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(
                pokemon: poke,
              )));
            },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 4.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(poke.img)
                        )
                      ),
                    ),
                    Text(poke.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
          ),
        ),
      )).toList(),
    );
  }
}

