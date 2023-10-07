import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child:Column(
          children: [
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Get.toNamed('/lista'),
          child: Text('Navegar3'),
        ),
        SizedBox(height: 20),
          ],
        )
      ),
    );
  }
}