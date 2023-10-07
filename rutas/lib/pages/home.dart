// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rutas/pages/lista.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child:Column(
          children: [
            ElevatedButton(
          onPressed: (){
            //esta es la forma mas vieja de hacerlo y no es recomendable://///
            MaterialPageRoute route = MaterialPageRoute(builder: (context) => const ListPage());
            Navigator.push(context,route);
          },
          child: Text('Navegar1'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: (){
            //ahora aplicamos el otro modo mas ordenado
            Navigator.pushNamed(context,"/lista");
          },
          child: Text('Navegar2'),
        ),
        SizedBox(height: 20),
          ],
        )
      ),
    );
  }
}