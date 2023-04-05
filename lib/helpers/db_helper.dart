import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    //Create a database if we dont have one, or finds the one we already have...
    //"places.db" a place created in the path "dbPath" that caan be used to store extensions...
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      //Executes a function when sql tries to create a new file because it could not find the file in a database
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT,)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DBHelper.database();
    sqlDb.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); // "ConflictAlgorithm.replace replaces if the id was there before...
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DBHelper.database();
    //To get data from the database, use '.query()' method
    return sqlDb.query(table);
  }
}
