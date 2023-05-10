import 'package:flutter_list_times/models/times_model.dart';
import 'package:flutter_list_times/repository/times_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  DataBase._();
  static final DataBase instance = DataBase._();
  static const int _version = 1;
  static const String _dbName = 'times.db';

  static get() async {
    return await DataBase.instance.database;
  }

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
          'pontos': time.pontos,
          'brasao': time.brasao,
          'cor':
              time.cor.toString().replaceAll('Color(', '').replaceAll(')', ''),
          //'idAPI': time.idAPI,
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
