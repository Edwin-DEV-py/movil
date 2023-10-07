// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //definimos los campos del formulario
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool accept = false;


  //aqui es donde hacemos el future
  Future<String> fetchAuthToken(String username, String password) async {
    final Map<String, dynamic> requestBody = {
      'username': username,
      'password': password,
    };

    //mandamos la peticion a la API
    final response = await http.post(
      Uri.parse('http://192.168.56.1:8000/api/token/'), //esta ip se utiliza para que flutter pueda acceder al servidor django. (ip d ela maquina local)
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      //serializar el cuerpo
      body: json.encode(requestBody),
    );

    //evaluamos la respuesta
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final access = data['access'];
      print(access);

      //Guardamos el token
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('access', access);
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
        if(accept)
        {
          Navigator.pushNamed(context, '/Lista');
        }else{
          Navigator.pushNamed(context, '/Home');
        }
      }

      
    } catch (e) {
      // Manejo de error
      print('Error: $e');
    }
  }

  Future<void> _authenticateWithFingerprint() async {
      final localAuth = LocalAuthentication();
      final isFingerprintAvailable = await localAuth.canCheckBiometrics;

      if (isFingerprintAvailable) {
        try {
          final isAuthenticated = await localAuth.authenticate(
            localizedReason: 'Autenticación requerida',
          );

          if (isAuthenticated) {
            //Obtener el token para usarlo e iniciar sesion
            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('access');

            if (token != null) {
              Navigator.pushNamed(context, '/Lista');
            }
          }
        } on PlatformException catch (e) {
          print('Error de autenticación por huella digital: $e');
        }
      } else {
        print('El dispositivo no admite la autenticación por huella digital');
      }
    }


  //Aca obtenemos el token que esta guardado
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs){
      final ac = prefs.getBool('accept');
      if(ac != null){
        //cambiar estado a
        setState(() {
          accept = true;
        });
        
      }
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              child: Text('Inicia sesion'),
            ),
            if(accept)
              ElevatedButton(
                onPressed: (){
                  _authenticateWithFingerprint();
                }, 
                child: Text('Ingresa con huella')
              )
          ],
        ),
      ),
    );
  }
}