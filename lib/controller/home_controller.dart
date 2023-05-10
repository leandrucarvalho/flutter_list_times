import 'package:flutter/material.dart';
import 'package:flutter_list_times/models/times_model.dart';
import 'package:flutter_list_times/repository/times_repository.dart';

class HomeController extends ChangeNotifier {
  final TimesRepository _repository;
  List<Time> times = [];

  HomeController(this._repository);

  Future<void> init() async {
    times = await _repository.getAll();
    notifyListeners();
  }
}
