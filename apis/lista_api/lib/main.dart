// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lista_api/api_estudents.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class EstudentContainer extends StatelessWidget {
  //datos que mostraremos en la lista
    final String name;
    final String grade;
    final int prom;
    const EstudentContainer({
      Key? key,
      required this.name,
      required this.grade,
      required this.prom,
    }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 44, 107, 243),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              grade,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              prom.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ]
        ),)
      ),
    );
  }
}