// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//Pagina del home donde estan los botones de favorito y productos
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Menu Principal', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/Articulos');
                      }, 
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: const Color.fromARGB(255, 39, 133, 209),
                        side: BorderSide(width: 2,color:Colors.black),
                        padding: EdgeInsets.all(20)
                      ),
                      child: Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/512/116/116356.png'),width: 50,)
                    ),
                    Text('Productos', style: TextStyle(color: const Color.fromARGB(255, 39, 133, 209), fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                ) 
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/Favorito');
                      }, 
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: const Color.fromARGB(255, 208, 240, 31),
                        side: BorderSide(width: 2,color:Colors.black),
                        padding: EdgeInsets.all(20)
                      ),
                      child: Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/512/561/561238.png'),width: 50,)
                    ),
                    Text('Favoritos', style: TextStyle(color: Color.fromARGB(255, 208, 240, 31), fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                ) 
              ],
            ),
          ],
        ),
      ),
    );
  }
}