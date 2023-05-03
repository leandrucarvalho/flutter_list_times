import 'package:flutter/material.dart';
import 'package:flutter_list_times/controller/home_controller.dart';
import 'package:flutter_list_times/models/times_model.dart';
import 'package:flutter_list_times/pages/time_details_page.dart';
import 'package:flutter_list_times/repository/times_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brasileirão'),
        centerTitle: true,
      ),
      body: Consumer<TimesRepository>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.times.length,
            itemBuilder: (BuildContext context, int index) {
              final List<Time> tabela = repositorio.times;
              return ListTile(
                leading: Hero(
                  tag: tabela[index].nome,
                  child: Image.network(tabela[index].brasao),
                ),
                title: Text(tabela[index].nome),
                subtitle: Text(
                  'Titulos: ${tabela[index].titulos.length}',
                ),
                trailing: Text(
                  tabela[index].pontos.toString(),
                ),
                onTap: () {
                  Get.to(
                    () => TimeDetailsPage(
                      key: Key(tabela[index].nome),
                      time: tabela[index],
                    ),
                  );
                },
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            padding: const EdgeInsets.all(16),
          );
        },
      ),
    );
  }
}
