import 'package:geolocator/geolocator.dart';

Future<Position> obtenerGps() async {
  //Verificar si la ubicación del dispositivo está habilitada
  bool bGpsHabilitado = await Geolocator.isLocationServiceEnabled();
  if (!bGpsHabilitado) {
    return Future.error('Por favor habilite el servicio de ubicación.');
  }
  //Validar permiso para utilizar los servicios de localización
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
  //En este punto los permisos están habilitados y se puede consultar la ubicación
  return await Geolocator.getCurrentPosition();
}
