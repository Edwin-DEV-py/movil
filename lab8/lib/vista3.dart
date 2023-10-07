// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Vista3 extends StatelessWidget{
  final String color;

  Vista3({
    required this.color
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Vista 3'),),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: 30,),
              Text('Boton presionado'),
              SizedBox(height: 10,),
              Text(color, style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          )
        ],
      ),
    );
  }
}