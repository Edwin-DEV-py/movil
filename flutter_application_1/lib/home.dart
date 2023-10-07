// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  bool accept = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista habilitar huella'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(
              'Habilitar login con huella',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _updateAccept(true); // Actualiza accept a true 
                Navigator.pushNamed(context, '/Login');
              },
              child: Text('Habilitar'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 110, 224, 113)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateAccept(bool newValue) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('accept', newValue);
  setState(() {
    accept = newValue;
  });
}
}
