
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_2/grid_articulo.dart';
import 'package:quiz_2/item_articulo.dart';
import 'package:quiz_2/model.dart';
import 'package:quiz_2/sqlite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ofertas extends StatefulWidget {
  const Ofertas({super.key});

  @override
  State<Ofertas> createState() => _OfertasState();
}

class _OfertasState extends State<Ofertas> {
  bool authenticated = false;
  bool grid = true;

  List<ArticulosModel> articulos = [];

  void fetchData(String access) async{
    try{
      //url donde estan los datos
      http.Response response = await http.get(Uri.parse('http://172.21.192.1:8000/api/products/'),
      headers: {
        'Authorization': 'JWT $access'
      }
      );
      //obtenemos el cuerpo del json
      final data = json.decode(response.body);
      var products = data['all_products'];

      //vaciar la db antes dde llenarla:
      await DatabaseService.deleteAll();
      //aqui mapeamos la parte de elementos donde estan los datos de los usuarios
      products.forEach((art) async{
        bool favorito = art['is_favorite'];
        ArticulosModel articulo = ArticulosModel(
          id: art['id'],
          articulo: art['name'], 
          urlimagen: art['img'], 
          vendedor: art['saler'], 
          calificaciones: art['calificaciones'],
          favourite: art['is_favorite']
          );
        articulos.add(articulo); //metemos los datos a la lista

        //Guardar en SQLITE los productos favortios del usuario
        if(favorito){
          await DatabaseService.createItem(articulo.articulo, articulo.vendedor, articulo.calificaciones);
        }
      });
        setState(() {});
        final articulosM = await DatabaseService.getItems();
        for ( final arti in articulosM){
          print('Id: ${arti['id']}, articulo: ${arti['articulo']}, vendedor: ${arti['vendedor']}, calificaciones: ${arti['calificaciones']},');
        }
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

  //cerrar sesion desde el AppBar
  Future<void> logoutButton() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access');

      setState(() {
        authenticated = false; //cambiar el estadoz
      });
    }

  

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(title: Text('Lista de articulos'),
      backgroundColor: const Color.fromARGB(255, 231, 92, 36),

      //IconButtons para cerrar sesion y cambiar la distribucion
      actions: [
        if(authenticated)
          IconButton(onPressed: (){
            logoutButton();
            Navigator.pushNamed(context, '/Login');
            DatabaseService.deleteAll();
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

          //Verificar la variable
          if (grid)
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Define que la cuadricula tiene 2 columnas
              ),
              shrinkWrap: true, //Se adapta al contenedor
              physics: NeverScrollableScrollPhysics(), //La cuadricula no se desplaza
              itemCount: articulos.where((e) => e.favourite).length, //Solo mostrar favoritos
              itemBuilder: (BuildContext context, int index) {
                final favoritos = articulos.where((e) => e.favourite).toList(); //Estop crea un ListView
                return GridContainer(
                  articulo: favoritos[index].articulo,
                  urlimagen: favoritos[index].urlimagen,
                  vendedor: favoritos[index].vendedor,
                  calificaciones: favoritos[index].calificaciones,
                  id: favoritos[index].id,
                  favourite: favoritos[index].favourite,
                );
              },
            )
          else //Si es falsa la muestra en lista vertical
            //Los 3 puntos indican el operador de propagacion para transformar los elementos
            //de articulos en un alista de elementos.
            ...articulos.where((e) => e.favourite).map(
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
      ),
    );
  }
}