import 'package:flutter/material.dart';
import 'package:lab8/vista3.dart';

class Boton2 extends StatefulWidget {
  const Boton2({super.key});

  @override
  State<Boton2> createState() => _Boton2State();
}

class _Boton2State extends State<Boton2> {
  Widget botones(String txt, Color color, String value) {
    return ElevatedButton(
      onPressed: (){
        MaterialPageRoute route = MaterialPageRoute(builder: (context) => Vista3(color: value,));
        Navigator.push(context, route);
      }, 
      child: Text(txt),
      style: ElevatedButton.styleFrom(backgroundColor: color,fixedSize: Size(200,20)),
      );
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
              await showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 350,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          botones('Boton Lila', Colors.purple, 'Lila'),
                          SizedBox(height: 20,),
                          botones('Boton Rojo', Colors.red, 'Rojo'),
                          SizedBox(height: 20,),
                          botones('Boton Naranja', Colors.orange, 'Naranja')
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          ],
        )   
    ]);
  }
}