import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_times/controller/get_docid_controller.dart';
import 'package:flutter_list_times/controller/home_controller.dart';
import 'package:flutter_list_times/controller/login_controller.dart';
import 'package:flutter_list_times/controller/theme_controller.dart';
import 'package:flutter_list_times/database/get_user_name.dart';
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
  late GetDocIdController getDocIdController;
  final loginController = AuthService();

  @override
  void initState() {
    controller = context.read<HomeController>();
    getDocIdController = context.read<GetDocIdController>();
    controller.init();
    getDocIdController.getDocId();
    super.initState();
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
              child: Consumer<GetDocIdController>(
                builder: (context, getDocIdController, child) {
                  return Column(
                    children: [
                      ExpansionTile(
                        title: const Text('Conta'),
                        childrenPadding: const EdgeInsets.only(left: 60),
                        children: [
                          Builder(
                            builder: (context) {
                              return ListTile(
                                title: Text('${user.email}'),
                              );
                            },
                          ),
                          ListTile(
                            onTap: () {
                              loginController.signOut();
                            },
                            title: const Text('Sair'),
                            trailing: const Icon(Icons.logout),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: const Text('Usuários cadastrados na plataforma'),
                        childrenPadding: const EdgeInsets.only(left: 60),
                        children: [
                          ListTile(
                            onTap: () {
                              getDocIdController.getDocId();
                            },
                            trailing: const Icon(FontAwesomeIcons.arrowsUpDown),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: getDocIdController.docIDs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: GetUserName(
                                  getDocIdController.docIDs[index],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  );
                },
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
