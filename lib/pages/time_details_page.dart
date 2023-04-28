// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_list_times/models/times_model.dart';
import 'package:flutter_list_times/models/tituto_model.dart';
import 'package:flutter_list_times/pages/add_titulo_page.dart';

class TimeDetailsPage extends StatefulWidget {
  final Time time;
  const TimeDetailsPage({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  State<TimeDetailsPage> createState() => _TimeDetailsPageState();
}

class _TimeDetailsPageState extends State<TimeDetailsPage> {
  tituloPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTituloPage(time: widget.time, onSave: addTitulo),
      ),
    );
  }

  addTitulo(Titulo titulo) {
    setState(() {
      widget.time.titulos.add(titulo);
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Salvo com sucesso!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.time.cor,
          title: Text(widget.time.nome),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: tituloPage,
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.stacked_line_chart),
                text: 'Estatísticas',
              ),
              Tab(
                icon: Icon(Icons.emoji_events_outlined),
                text: 'Estatísticas',
              )
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: widget.time.nome == 'Santa Cruz'
                      ? SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            widget.time.brasao,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.network(
                          widget.time.brasao.replaceAll('40x40', '100x100'),
                        ),
                ),
                Text(
                  'Pontos: ${widget.time.pontos}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
            titulos()
          ],
        ),
      ),
    );
  }

  Widget titulos() {
    final quantidade = widget.time.titulos.length;
    return quantidade == 0
        ? const Center(
            child: Text('Nenhum Titulo Ainda!'),
          )
        : ListView.separated(
            itemBuilder: (BuildContext context, index) {
              return ListTile(
                leading: const Icon(Icons.emoji_events),
                title: Text(widget.time.titulos[index].campeonato),
                trailing: Text(widget.time.titulos[index].ano),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: quantidade,
          );
  }
}
