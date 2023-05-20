import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_times/controller/home_controller.dart';
import 'package:flutter_list_times/controller/theme_controller.dart';
import 'package:flutter_list_times/pages/time_details_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/times_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;
  final user = FirebaseAuth.instance.currentUser!;
  final userName = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    controller = context.read<HomeController>();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            );
          },
        ),
        title: const Text('Brasileirão'),
        centerTitle: true,
        actions: [
          Consumer<ThemeController>(
            builder: (contex, themeController, _) {
              return IconButton(
                onPressed: () {
                  themeController.toggleTheme();
                },
                icon: const Icon(Icons.auto_fix_high_outlined),
              );
            },
          )
        ],
      ),
      drawer: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  ExpansionTile(
                    title: const Text('Conta'),
                    childrenPadding: const EdgeInsets.only(left: 60),
                    children: [
                      ListTile(
                        title: Text(user.email!),
                      ),
                      ListTile(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        title: const Text('Sair'),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return ListView.separated(
            itemCount: controller.times.length,
            itemBuilder: (BuildContext context, int index) {
              final List<Time> tabela = controller.times;
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
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TimeDetailsPage(
                        key: Key(tabela[index].nome),
                        time: tabela[index],
                      ),
                    ),
                  );
                  controller.init();
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
