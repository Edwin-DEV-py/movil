// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rutas/pages/home.dart';
import 'package:rutas/pages/lista.dart';

void main() {
  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      //esta es la forma mas sencilla y ordenada, donde tenemos las rutas ya definidas
      initialRoute: '/',
      routes: {
        '/':(context) => HomePage(),
        '/lista':(context) => ListPage()
      },
    );
  }
}
