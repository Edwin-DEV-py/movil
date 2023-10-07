//Modelo de los articulos
class ArticulosModel{
  late int id;
  late String articulo;
  late String vendedor;
  late String urlimagen;
  late int calificaciones;
  late bool favourite;

  ArticulosModel({
    required this.articulo,
    required this.vendedor,
    required this.urlimagen,
    required this.calificaciones,
    required this.favourite,
    required this.id
  });

  //Metodo toMap para la DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'articulo': articulo,
      'vendedor': vendedor,
      'urlimagen': urlimagen,
      'calificaciones': calificaciones,
      'favourite': favourite ? 1 : 0,
    };
  }
}