import 'package:flutter/material.dart';
import 'package:flutter_list_times/controller/home_controller.dart';
import 'package:flutter_list_times/models/times_model.dart';
import 'package:flutter_list_times/pages/time_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic controller;

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
      body: ListView.separated(
        itemCount: controller.tabela.length,
        itemBuilder: (BuildContext context, int index) {
          final List<Time> tabela = controller.tabela;
          return ListTile(
            leading: Image.network(tabela[index].brasao),
            title: Text(tabela[index].nome),
            trailing: Text(
              tabela[index].pontos.toString(),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TimeDetailsPage(
                    key: Key(tabela[index].nome),
                    time: tabela[index],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
