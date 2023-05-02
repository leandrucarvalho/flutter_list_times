import 'package:flutter/material.dart';
import 'package:flutter_list_times/models/tituto_model.dart';

class Time {
  String brasao;
  String nome;
  int pontos;
  Color cor;
  List<Titulo> titulos;

  Time({
    required this.pontos,
    required this.nome,
    required this.brasao,
    required this.cor,
    required this.titulos,
  });
}
