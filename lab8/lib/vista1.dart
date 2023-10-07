// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lab8/boton.dart';

class Vista1 extends StatefulWidget {
  const Vista1({super.key});

  @override
  State<Vista1> createState() => _Vista1State();
}

class _Vista1State extends State<Vista1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vista 1'),actions: [
        ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/vista2');}, child: Text('Vista 2 ->'))
      ],),
      body: Boton(),
    );
  }
}