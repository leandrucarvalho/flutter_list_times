import 'package:flutter/material.dart';
import 'package:flutter_list_times/models/tituto_model.dart';

import '../models/times_model.dart';

class TimesRepository {
  final List<Time> _times = [];

  get times => _times;

  void addTitulo({required Time time, required Titulo titulo}) {
    time.titulos.add(titulo);
  }

  TimesRepository() {
    _times.addAll([
      Time(
        nome: 'Santa Cruz',
        pontos: 100,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/santa-cruz.png',
        cor: Colors.red,
      ),
      Time(
        nome: 'Flamengo',
        pontos: 71,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/flamengo.png',
        cor: Colors.red,
      ),
      Time(
        nome: 'Internacional',
        pontos: 69,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/internacional.png',
        cor: Colors.red,
      ),
      Time(
        nome: 'Atlético-MG',
        pontos: 65,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/atletico-mg.png',
        cor: Colors.red,
      ),
      Time(
        nome: 'São Paulo',
        pontos: 63,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/sao-paulo.png',
        cor: Colors.red,
      ),
      Time(
        nome: 'Fluminense',
        pontos: 71,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/fluminense.png',
        cor: Colors.red,
      ),
      Time(
        nome: 'Grêmio',
        pontos: 59,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/gremio.png',
        cor: Colors.blue,
      ),
      Time(
        nome: 'Palmeiras',
        pontos: 58,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/palmeiras.png',
        cor: Colors.green,
      ),
      Time(
        nome: 'Santos',
        pontos: 54,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/santos.png',
        cor: Colors.black87,
      ),
      Time(
        nome: 'Athletico-PR',
        pontos: 50,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/athletico-pr.png',
        cor: Colors.red,
      ),
      Time(
        nome: 'Corinthians',
        pontos: 50,
        brasao: 'https://e.imguol.com/futebol/brasoes/40x40/corinthians.png',
        cor: Colors.red,
      ),
    ]);
  }
}
