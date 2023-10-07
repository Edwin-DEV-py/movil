// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  int value = 0;

  _changeValue() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      value = value+1;
      prefs.setInt("value", value);
    });
  }

  @override
  void initState(){
    super.initState();
    _carfar();
  }

  _carfar()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? store = prefs.getInt("value");
    if (store != null){
    setState(() {
      value = store;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Persistencia"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(value.toString()),
              ),
              ElevatedButton(onPressed: _changeValue, child: Text("sumar++"))
            ]
          ),
        ),
      ),
    );
  }
}