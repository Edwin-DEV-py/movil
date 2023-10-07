// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lab8/vista1.dart';
import 'package:lab8/vista2.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main',
      initialRoute: '/',
      routes: {
        '/':(context) => Vista1(),
        '/vista2':(context) => Vista2()
      },
    );
  }
}
