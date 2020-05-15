import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  final url;

  NewPage({this.url});

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF232A34),
      ),
      body: Container(
        child: Center(
          child: Image.network(widget.url),
        ),
      ),
    );
  }
}
