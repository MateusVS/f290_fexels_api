import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() async {
    super.initState();
    obterDadosPokeAPI();
  }

  obterDadosPokeAPI() async {
    http.Response response = await http.get('https://pokeapi.co/api/v2/pokemon/pikachu');
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pexels Search"),
        backgroundColor: Color(0xFF232A34),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text('Scaffold')),
        ],
      ),
    );
  }
}