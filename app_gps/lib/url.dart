import 'package:url_launcher/url_launcher.dart';

Future<void> abrirUrl(final String sUrl) async {
  final Uri oUri = Uri.parse(sUrl);
  try {
    await launchUrl(
      oUri, //Ej: http://www.google.com/maps/place/6.2502089,-75.5706711
      mode: LaunchMode.externalApplication
    );
  } catch (oError){
    return Future.error('No fue posible abrir la url: $sUrl.');
  }
}

