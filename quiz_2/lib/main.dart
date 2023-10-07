// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quiz_2/articulos.dart';
import 'package:quiz_2/home.dart';
import 'package:quiz_2/login.dart';
import 'package:quiz_2/ofertas.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //verificar enlaces antes de verificar  el token.
  final authenticated = await token();
  runApp(MainApp(authenticated: authenticated));
}

class MainApp extends StatelessWidget {

  final bool authenticated;

  const MainApp({super.key, required this.authenticated});

  //Aca definimos las rutas
  @override
  Widget build(BuildContext context){ 
    return MaterialApp(
      title: 'Quiz',
      initialRoute: authenticated ? '/' : '/Login', //si hay token lo lleva a los articulos
      routes: {
        '/':(context) => HomePage(),
        '/Articulos':(context) => Articulos(),
        '/Login':(context) => LoginPage(),
        '/Favorito':(context) => Ofertas()
      },
    );
  }
}

//ver si el token existe
  Future<bool> token() async{
    final prefs = await SharedPreferences.getInstance();
    final access = prefs.getString('access');
    return access != null;
  }
