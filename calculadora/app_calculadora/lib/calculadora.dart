//escribiendo stfl nos da un atajo de teclado para crear una estructura rapidamente
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables //esto ignora las alertas que piden agregar el const

import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatortState();
}

class _CalculatortState extends State<Calculator> {
  //funcion que devuelve un widget para crear un boton personalizado
  Widget button(String txt, Color buttoncolor, Color textcolor){ //parametros del boton
    return ElevatedButton(
      onPressed: () => {operation(txt)}, //accion a ejecutar cuando se precione un boton
      style:ElevatedButton.styleFrom( //darle estilo al boton
        fixedSize: const Size(80,80), //tamano del boton
        backgroundColor: buttoncolor 
      ),
      child: Text( //contenido del boton
        txt,
        style: TextStyle(fontSize: 30, color: textcolor),//tamano de la fuente
      )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      //barra superior con el nombre de la aplicacion
      appBar: AppBar(
        title: const Text("Calculadora"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5), //espaciado entre botones
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, //esto dice que empieze desde abajo o el final
          children: [
            //fila donde se mostrara el texto
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 70),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            //primer expanded donde se econtrarar los digitos(0-9), el punto y el =.
            Expanded(
              child: Row(
                children:[
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            button("AC", Colors.orange, Colors.white),
                            button("CE", Colors.orange, Colors.white),
                            button("%", Colors.black, Colors.white),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            button("7", Colors.black, Colors.white),
                            button("8", Colors.black, Colors.white),
                            button("9", Colors.black, Colors.white),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            button("4", Colors.black, Colors.white),
                            button("5", Colors.black, Colors.white),
                            button("6", Colors.black, Colors.white),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            button("1", Colors.black, Colors.white),
                            button("2", Colors.black, Colors.white),
                            button("3", Colors.black, Colors.white),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            button("0", Colors.black, Colors.white),
                            button(".", Colors.black, Colors.white),
                            button("=", Colors.black, Colors.white),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                      )
                    ),
                    //segundo expanded, aca se encontrara los simbolos par hacer las operaciones basicas
                    Expanded(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            button("/", Colors.black, Colors.white),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            button("x", Colors.black, Colors.white),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            button("-", Colors.black, Colors.white),
                          ],
                        ),
                        SizedBox(height: 10),
                        //boton especial para la suma, para darle doble espaciado vertical
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => {operation("+")},
                              style:ElevatedButton.styleFrom(
                                fixedSize: const Size(80,170),
                                backgroundColor: Colors.black 
                              ),
                              child: Text(
                                "+",
                                style: TextStyle(fontSize: 30, color: Colors.white),
                              )
                            )
                          ],
                          ),
                          SizedBox(height: 20),
                      ],
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
        )
    );
  }
//definimos las variables para las operaciones
String text = "";
String rta = "";
String op = "";
int x = 0;
int y = 0;

//funcion que hara las operaciones, se coge el parametro que definimos como txt de acda boton y asi sabemos que digito se usara.

void operation(String txt){
  if (txt == "CE"){
    rta = "";
    text = "";
    x = 0;
    y = 0;
  }
  //colocamos un bloque try dnetro del if para validar los operadores
  else if(txt == "+" ||txt == "-" ||txt == "x" ||txt == "/" ||txt == "%" ){
    try{
      x = int.parse(text);
      rta = "";
      op = txt;
    }catch(e){
      if (e is FormatException){ //aqui colocamos esta excepcion por si acaso el usuario oprime un operador sin antes poner un numero y asi evitamos parar el sistema.
        print("Error, operacion no valida");
      }
    }
  }
  //aqui se haran las operaciones
  else if(txt == "="){
    y = int.parse(text);
    if(op == "+"){
      rta = (x + y).toString();
    }
    if(op == "-"){
      rta = (x - y).toString();
    }
    if(op == "x"){
      rta = (x * y).toString();
    }
    if(op == "/"){
      rta = (x / y).toString();
    }
    if(op == "%"){
      rta = (x % y).toString();
    }
  }
  else{
    rta = int.parse(text + txt).toString();
  }
  //se mostrara la rta en el texto
  setState(() {
    text = rta;
  });
}
}

