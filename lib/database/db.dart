import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  static const int _version = 1;
  static const String _dbName = 'times.db';

  Future<Database> get database async {
    return await openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: _version,
      onCreate: (db, version) async {
        await db.execute(times);
        await db.execute(titulos);
      },
    );
  }

  String get times => '''
    CREATE TABLE times (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      nome TEXT,
      pontos INTEGER,
      brasao TEXT,
      cor TEXT,
      idAPI INTEGER
    );
  ''';

  String get titulos => '''
    CREATE TABLE titulos (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      campeonato TEXT,
      ano TEXT,
      time_id INTEGER,
      FOREIGN KEY (time_id) REFERENCES times(id) ON DELETE CASCADE
    );
  ''';
}
