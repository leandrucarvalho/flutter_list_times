import 'package:flutter_list_times/models/times_model.dart';
import 'package:flutter_list_times/repository/times_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  static const int _version = 1;
  static const String _dbName = 'times.db';

  final db = DataBase().database;

  Future<Database> get database async {
    return await openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: _version,
      onCreate: (db, version) async {
        await db.execute(times);
        await db.execute(titulos);
        await setupTimes(db);
      },
    );
  }

  setupTimes(db) async {
    for (Time time in TimesRepository.setupTimes()) {
      await db.insert(
        'times',
        {
          'nome': time.nome,
          'brasao': time.brasao,
          'pontos': time.pontos,
          //'idAPI': time.idAPI,
          'cor':
              time.cor.toString().replaceAll('Color(', '').replaceAll(')', ''),
        },
      );
    }
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
