// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/grid_articulo.dart';
import 'package:flutter_application_1/item_articulo.dart';
import 'package:flutter_application_1/model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Articulos extends StatefulWidget {
  const Articulos({super.key});

  @override
  State<Articulos> createState() => _ArticulosState();
}

class _ArticulosState extends State<Articulos> {

  bool authenticated = false;
  bool grid = true;

  List<ArticulosModel> articulos = [];

  void fetchData(String access) async{

    //verificar si tiene token
    try{
      //url donde estan los datos
      http.Response response = await http.get(Uri.parse('http://192.168.56.1:8000/api/products/'),
      headers: {
        'Authorization': 'JWT $access'
      }
      );
      //obtenemos el cuerpo del json
      final data = json.decode(response.body);
      var products = data['all_products'];
      //aqui mapeamos la parte de elementos donde estan los datos de los usuarios
      products.forEach((art){
        ArticulosModel articulo = ArticulosModel(
          id: art['id'],
          articulo: art['name'], 
          urlimagen: art['img'], 
          vendedor: art['saler'], 
          calificaciones: art['calificaciones'],
          favourite: art['is_favorite']
          );
        articulos.add(articulo); //metemos los datos a la lista
      });
        setState(() {});
    }catch(e){
      print(e);
    }
    
  }

  //Aca obtenemos el token que esta guardado
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs){
      final access = prefs.getString('access');
      if(access != null){
        fetchData(access);

        //cambiar estado a
        setState(() {
          authenticated = true;
        });
        
      }
    });
  }

  //cambiar entre true y false
  void toggleGrid() {
    setState(() {
      grid = !grid;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de articulos'),
      backgroundColor: const Color.fromARGB(255, 43, 153, 46),
      //IconButtons para cerrar sesion y cambiar la distribucion
      actions: [
        if(authenticated)
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/Login');
          }, icon: Icon(Icons.logout)),
        if(authenticated)
          IconButton(
            onPressed: (){
              toggleGrid();
            }, 
            icon: Icon(grid ? Icons.list : Icons.grid_on)
          )
      ],
      ),
      body: ListView(
        //Construir el widget
        children: <Widget>[
          if (grid)
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Define que la cuadricula tiene 2 columnas
              ),
              shrinkWrap: true, //Se adapta al contenedor
              physics: NeverScrollableScrollPhysics(), //La cuadricula no se desplaza
              itemCount: articulos.length,
              itemBuilder: (BuildContext context, int index) { //Crear la lista
                return GridContainer(
                  articulo: articulos[index].articulo,
                  urlimagen: articulos[index].urlimagen,
                  vendedor: articulos[index].vendedor,
                  calificaciones: articulos[index].calificaciones,
                  id: articulos[index].id,
                  favourite: articulos[index].favourite,
                );
              },
            )
          else
            //Los 3 puntos indican el operador de propagacion para transformar los elementos
            //de articulos en un alista de elementos.
            ...articulos.map(
              (e) {
                return ContainerItem(
                  articulo: e.articulo,
                  urlimagen: e.urlimagen,
                  vendedor: e.vendedor,
                  calificaciones: e.calificaciones,
                  id: e.id,
                  favourite: e.favourite,
                );
              },
            ),
        ],
      )
    );
  }
}