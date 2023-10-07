import 'package:flutter/material.dart';
import 'package:flutter_application_1/articulos.dart';
import 'package:flutter_application_1/home.dart';

import 'login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      initialRoute: '/Login',
      routes: {
        '/Login':(context) => LoginPage(),
        '/Home':(context) => HomePage(),
        '/Lista':(context) => Articulos()
      },
    );
  }
}
