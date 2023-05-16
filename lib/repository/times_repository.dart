import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_list_times/database/db.dart';
import 'package:flutter_list_times/models/titulo_model.dart';

import '../models/times_model.dart';
import 'package:sqflite/sqflite.dart';

class TimesRepository extends ChangeNotifier {
  final List<Time> _times = [];

  final db = DataBase.instance;

  UnmodifiableListView<Time> get times => UnmodifiableListView(_times);

  void addTitulo({required Time time, required Titulo titulo}) async {
    final Database dbInstance = await db.database;
    int id = await dbInstance.insert('titulos', {
      'time_id': time.id,
      'campeonato': titulo.campeonato,
      'ano': titulo.ano
    });
    titulo.id = id;
    time.titulos.add(titulo);
    notifyListeners();
  }

  void editTitulo(
      {required Titulo titulo,
      required String ano,
      required String campeonato}) async {
    final Database dbInstance = await db.database;
    await dbInstance.update(
      'titulos',
      {'campeonato': titulo.campeonato, 'ano': titulo.ano},
      where: 'id = ?',
      whereArgs: [titulo.id],
    );
    titulo.ano = ano;
    titulo.campeonato = campeonato;
    notifyListeners();
  }

  static setupTimes() {
    return [
      Time(
        nome: 'Santa Cruz',
        pontos: 100,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/santa-cruz.png',
        cor: Colors.red,
        titulos: [],
        id: 1,
      ),
      Time(
        nome: 'Flamengo',
        pontos: 71,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/flamengo.png',
        cor: Colors.red,
        titulos: [],
        id: 2,
      ),
      Time(
        nome: 'Internacional',
        pontos: 69,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/internacional.png',
        cor: Colors.red,
        titulos: [],
        id: 3,
      ),
      Time(
        nome: 'Atlético-MG',
        pontos: 65,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/atletico-mg.png',
        cor: Colors.black45,
        titulos: [],
        id: 4,
      ),
      Time(
        nome: 'São Paulo',
        pontos: 63,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/sao-paulo.png',
        cor: Colors.red,
        titulos: [],
        id: 5,
      ),
      Time(
        nome: 'Fluminense',
        pontos: 71,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/fluminense.png',
        cor: Colors.red,
        titulos: [],
        id: 6,
      ),
      Time(
        nome: 'Grêmio',
        pontos: 59,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/gremio.png',
        cor: Colors.blue,
        titulos: [],
        id: 7,
      ),
      Time(
        nome: 'Palmeiras',
        pontos: 58,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/palmeiras.png',
        cor: Colors.green,
        titulos: [],
        id: 8,
      ),
      Time(
        nome: 'Santos',
        pontos: 54,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/santos.png',
        cor: Colors.black87,
        titulos: [],
        id: 9,
      ),
      Time(
        nome: 'Athletico-PR',
        pontos: 50,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/athletico-pr.png',
        cor: Colors.red,
        titulos: [],
        id: 10,
      ),
      Time(
        nome: 'Corinthians',
        pontos: 50,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/corinthians.png',
        cor: Colors.red,
        titulos: [],
        id: 11,
      ),
    ];
  }

  Future<List<Time>> getAll() async {
    _times.clear();
    final Database dbInstance = await db.database;
    final List times = await dbInstance.query('times');

    for (var time in times) {
      _times.add(
        Time(
          id: time['id'],
          nome: time['nome'],
          brasao: time['brasao'],
          pontos: time['pontos'],
          cor: Color(time['cor']),
          titulos: await getTitulos(time['id']),
        ),
      );
    }
    notifyListeners();
    return _times;
  }

  Future<List<Titulo>> getTitulos(timeId) async {
    final Database dbInstance = await db.database;
    final List results = await dbInstance
        .query('titulos', where: 'time_id = ?', whereArgs: [timeId]);
    List<Titulo> titulos = [];

    for (var titulo in results) {
      titulos.add(
        Titulo(
          id: titulo['time_id'],
          campeonato: titulo['campeonato'],
          ano: titulo['ano'],
        ),
      );
    }
    notifyListeners();
    return titulos;
  }
}
