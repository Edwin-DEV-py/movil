// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:app_gps/geolocator.dart';
import 'package:app_gps/url.dart';

void main() {
  runApp(MaterialApp(
    home: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Aplicacion de GPS'),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.blue[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Google_Maps_Logo_2020.svg/2275px-Google_Maps_Logo_2020.svg.png'),width: 200,)],),
                  SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    ElevatedButton(
                      onPressed: (){
                        obtenerGps().then((label){
                          String url = 'http://www.google.com/maps/place/${label.latitude},${label.longitude}';
                          abrirUrl(url);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                      ),
                      child: Text('Ver tu Ubicacion'))
                  ],)
                ]
              ),
            )
          ],
          )
      ),
    );
  }
}
