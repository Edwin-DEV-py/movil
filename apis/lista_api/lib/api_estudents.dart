// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lista_api/main.dart';
import 'dart:convert';
import 'package:lista_api/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<EstudentModel> estudents = [];
  
  //obtenemos los datos de la api de Django
  void fetchData() async{
    try{
      //hacemos una solicitud get a la api
      http.Response response = await http.get(Uri.parse('http://10.0.2.2:8000/api/estudents'));
      var data = json.decode(response.body);
      //introducimos todos los datos de la api a una lista para poder utilziarlos
      data.forEach((estudent){
        EstudentModel es = EstudentModel(
          name: estudent['name'], 
          grade: estudent['grade'], 
          prom: estudent['prom']);
          estudents.add(es);
      });
      print(estudents.length);
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Estudiantes')),
      body: ListView(
        children:
          estudents.map((e) {
            return EstudentContainer(
              name: e.name, 
              grade: e.grade, 
              prom: e.prom);
          }).toList(),
      )
    );
  }
}