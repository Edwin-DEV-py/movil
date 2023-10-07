// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //definimos los campos del formulario
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  //aqui es donde hacemos el future
  Future<String> fetchAuthToken(String username, String password) async {
  final Map<String, dynamic> requestBody = {
    'username': username,
    'password': password,
  };

  //mandamos la peticion a la API
  final response = await http.post(
    Uri.parse('http://172.27.96.1:8000/api/token/'), //esta ip se utiliza para que flutter pueda acceder al servidor django. (ip d ela maquina local)
    headers: <String, String>{
      'Content-Type': 'application/json'
    },
    //serializar el cuerpo
    body: json.encode(requestBody),
  );

  //evaluamos la respuesta
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('Response: $data');
    return data['access']; //obtenemos el token
  } else {
    throw Exception('Failed to authenticate');
  }
}

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final token = await fetchAuthToken(username, password);
      if (token == token) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()), // Navega a la pantalla principal
        );
      }
    } catch (e) {
      // Manejo de error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png'),width: 250,),
            SizedBox(height: 20,),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username',border: OutlineInputBorder()),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder()
              ),
              obscureText: true,
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text('Bienvenido'),
      ),
    );
  }
}
