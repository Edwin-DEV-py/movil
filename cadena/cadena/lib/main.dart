// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nombre = TextEditingController();
  final contrasena = TextEditingController();

  Future<String?> fetchAuthToken(String username, String password) async {
    final Map<String, dynamic> respuesta = {
      'username': username,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/auth/jwt/create'),
        headers: <String, String>{'Content-Type': 'application/json',},
        body: json.encode(respuesta),
      );
        final data = json.decode(response.body);
        return data['access'];

    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> _login() async {
    final username = nombre.text;
    final password = contrasena.text;

    try {
      final token = await fetchAuthToken(username, password);
      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(userName: username),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nombre,
              decoration: InputDecoration(labelText: 'nombre'),
            ),
            TextField(
              controller: contrasena,
              decoration: InputDecoration(labelText: 'contrasena'),
              obscureText: true,
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final String userName;

  Home({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hola, $userName!'),
          ],
        ),
      ),
    );
  }
}
