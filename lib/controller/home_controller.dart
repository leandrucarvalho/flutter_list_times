import 'package:flutter_list_times/models/times_model.dart';
import 'package:flutter_list_times/repository/times_repository.dart';

class HomeController {
  late TimesRepository timesRepository;

  List<Time> get tabela => timesRepository.times;

  HomeController() {
    timesRepository = TimesRepository();
  }
}
