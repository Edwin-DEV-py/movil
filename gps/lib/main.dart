import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Abrir URL en Google Maps'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              obtenerGps().then((position) {
                String url = 'http://www.google.com/maps/place/${position.latitude},${position.longitude}';
                abrirUrl(url).catchError((error) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(error.toString()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar'),
                          ),
                        ],
                      );
                    },
                  );
                });
              });
            },
            child: Text('Abrir URL en Google Maps'),
          ),
        ),
      ),
    );
  }
}

Future<void> abrirUrl(final String sUrl) async {
  final Uri oUri = Uri.parse(sUrl);
  try {
    await launchUrl(
      oUri,
      mode: LaunchMode.externalApplication
    );
  } catch (oError) {
    throw Exception('No fue posible abrir la URL: $sUrl.');
  }
}

Future<Position> obtenerGps() async {
  bool bGpsHabilitado = await Geolocator.isLocationServiceEnabled();
  if (!bGpsHabilitado) {
    return Future.error('Por favor habilite el servicio de ubicación.');
  }

  LocationPermission bGpsPermiso = await Geolocator.checkPermission();
  if (bGpsPermiso == LocationPermission.denied) {
    bGpsPermiso = await Geolocator.requestPermission();
    if (bGpsPermiso == LocationPermission.denied) {
      return Future.error('Se denegó el permiso para obtener la ubicación.');
    }
  }

  if (bGpsPermiso == LocationPermission.deniedForever) {
    return Future.error('Se denegó el permiso para obtener la ubicación de forma permanente.');
  }

  return await Geolocator.getCurrentPosition();
}
