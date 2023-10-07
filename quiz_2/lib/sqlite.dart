// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseService {
  static Future<void> createTable(sql.Database database) async{
    await database.execute(
      "CREATE TABLE favoritos (id INTEGER PRIMARY KEY, articulo TEXT, vendedor TEXT, urlimagen TEXT, calificaciones INTEGER, favourite BOOL)"
    );
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase(
      'favoritos.db',
      version: 1,
      onCreate: (sql.Database database, int version) async{
        await createTable(database);
      }
    );
  }

  //obtener articulos
  static Future<int> createItem(String articulo, String vendedor, int calificaciones) async{
    final db = await DatabaseService.db();

    final data = {'articulo': articulo, 'vendedor':vendedor, 'calificaciones':calificaciones};
    final id = await db.insert('favoritos', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //mostrar articulos
  static Future<List<Map<String, dynamic>>> getItems() async{
    final db = await DatabaseService.db();
    return db.query('favoritos', orderBy: "id");
  }

  static Future<void> deleteAll() async{
    final db = await DatabaseService.db();
    await db.delete('favoritos');
  }
}

