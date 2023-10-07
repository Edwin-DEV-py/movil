// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lab8/radioBotom.dart';

class Boton extends StatefulWidget {
  const Boton({super.key});

  @override
  State<Boton> createState() => _BotonState();
}

class _BotonState extends State<Boton> {
  String? _character2;
  String? temp;
  bool show = false;

  void cambiarColor(String? character) {
    setState(() {
      temp = character;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(height: 30,),
            ElevatedButton(
            child: Text('Mostrar opciones'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 20, 95, 156)),
            onPressed: () async{
              await showModalBottomSheet<String>(
                context: context,
                isDismissible: false,
                enableDrag: false,
                builder: (BuildContext context) {
                  return Container(
                    height: 350,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RadioBottom(cambiar: cambiarColor),
                          ElevatedButton(
                            child: const Text('Aceptar'),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 20, 95, 156)),
                            onPressed: (){
                              setState(() {
                                _character2 = temp;
                                show = true;
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          if(show)
            Text("Opcion seleccionada:"),
            Text(_character2?.toString() ?? "", style:  TextStyle(fontWeight: FontWeight.bold),) //si no tiene valor es nulo
          ],
        )   
    ]);
  }
}