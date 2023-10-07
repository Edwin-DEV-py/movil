import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isTwoRows = true;

  void toggleLayout() {
    setState(() {
      isTwoRows = !isTwoRows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cambiar distribución de filas'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isTwoRows
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              margin: EdgeInsets.all(8),
                              color: Colors.blue,
                              height: 100,
                              child: Center(
                                child: Text(
                                  'Elemento 0',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              margin: EdgeInsets.all(8),
                              color: Colors.blue,
                              height: 100,
                              child: Center(
                                child: Text(
                                  'Elemento 1',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              margin: EdgeInsets.all(8),
                              color: Colors.blue,
                              height: 100,
                              child: Center(
                                child: Text(
                                  'Elemento 2',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              margin: EdgeInsets.all(8),
                              color: Colors.blue,
                              height: 100,
                              child: Center(
                                child: Text(
                                  'Elemento 3',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: List.generate(
                        4,
                        (index) => Container(
                          width: MediaQuery.of(context).size.width - 16,
                          margin: EdgeInsets.all(8),
                          color: Colors.blue,
                          height: 100,
                          child: Center(
                            child: Text(
                              'Elemento $index',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
              ElevatedButton(
                onPressed: toggleLayout,
                child: Text(isTwoRows ? 'Cambiar a 1 por fila' : 'Cambiar a 2 arriba y 2 abajo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
