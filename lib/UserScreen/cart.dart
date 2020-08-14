import 'package:flutter/material.dart';

class Agrocart extends StatefulWidget {
  
  @override
  _AgrocartState createState() => _AgrocartState();
}

class _AgrocartState extends State<Agrocart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Agri go"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
