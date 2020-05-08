import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'dart:convert' as json;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() async {
    super.initState();
    _getImages().then((value) => print(value));
  }

  int _getCount(List data) {
    return data.length ?? 0;
  }

  static const String API_KEY = '563492ad6f917000010000018cea5845c8354912920099138687a563';

  final url = 'https://api.pexels.com/v1/curated?per_page=20&page=1';

  Future _getImages() async {
    http.Response response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: API_KEY
    });

    if (response.statusCode == 200) {
      return json.jsonDecode(response.body);
    } else {
      print("Erro ao obter imagens. Status Code ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232A34),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xFF232A34),
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Image.network(
                    'http://images.pexel.com/lib/api/pexels-white.png',
                    height: 35,
                    fit: BoxFit.fitHeight,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getImages(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: Loading (
                          indicator: BallPulseIndicator(),
                          size: 200,
                          color: Colors.white,
                        ),
                      );
                    default: 
                      if (snapshot.hasError) {
                        print('Erro: ${snapshot.error.toString()}');
                      } else {
                        return Container(color: Colors.green, );
                      }
                  }
                }
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _createImageGrid(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: _getCount(snapshot.data["photos"]),
      itemBuilder: (context, index) {
        return PexelImage(data: snapshot.data, index: index);
      },
    );
  }
}

class PexelImage extends StatelessWidget {
  final Map data;
  final int index;

  PexelImage({@required this.data, @required this.index});

  @override
  Widget build(BuildContext contex) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          data["photos"][index]["src"]["medium"],
          fit: BoxFit.cover,
          height: 300,
        ),
        //LabelImageData(data: data, index: index),
      ],
    );
  }
}