import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GridContainer extends StatefulWidget {
  final String articulo;
  final String urlimagen;
  final String vendedor;
  final int calificaciones;
  final bool favourite;
  final int id;

  GridContainer({
    Key? key,
    required this.articulo,
    required this.urlimagen,
    required this.vendedor,
    required this.calificaciones,
    required this.favourite,
    required this.id,
  }) : super(key: key);

  @override
  State<GridContainer> createState() => _GridContainerState();
}

class _GridContainerState extends State<GridContainer> {
  bool show2x2Grid = true;
  bool favoriteV = false;
  String? access;

  void toggleGrid() {
    setState(() {
      show2x2Grid = !show2x2Grid;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAccess();
  }

 @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Columna de la izquierda donde está la imagen
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage(widget.urlimagen),
                    width: 100,
                    height: 100,
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 200,), // Altura máxima
                    child: SingleChildScrollView( // Hacer el contenido desplazable
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                            widget.articulo,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                              if (widget.favourite)
                            IconButton(
                              onPressed: () {
                                if (access != null) {
                                  favorite(access!);
                                }
                              },
                              icon: Icon(
                                Icons.star,
                                color: const Color.fromARGB(255, 241, 218, 6),
                                size: 20,
                              ),
                            ),
                          if (!widget.favourite)
                            IconButton(
                              onPressed: () {
                                if (access != null) {
                                  favorite(access!);
                                }
                              },
                              icon: Icon(
                                Icons.star,
                                size: 20,
                              ),
                            ),
                            ],
                          ),
                          Text(
                            widget.vendedor,
                            maxLines: 2,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text('Calificaciones2: ${widget.calificaciones.toString()}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void loadAccess() async {
    final prefs = await SharedPreferences.getInstance();
    access = prefs.getString('access');
  }

  // Agregar a favoritos
  void favorite(String access) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://172.21.192.1:8000/api/favourite/'),
        headers: {
          'Authorization': 'JWT $access',
        },
        body: {
          'product_id': widget.id.toString(),
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          favoriteV = !favoriteV;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
