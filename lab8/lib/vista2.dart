// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lab8/boton2.dart';

class Vista2 extends StatefulWidget {
  const Vista2({super.key});

  @override
  State<Vista2> createState() => _Vista2State();
}

class _Vista2State extends State<Vista2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vista 2'),),
      body: Boton2(),
    );
  }
}