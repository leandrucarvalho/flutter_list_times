import 'package:flutter/material.dart';
import 'package:flutter_list_times/models/titulo_model.dart';
import 'package:flutter_list_times/repository/times_repository.dart';
import 'package:provider/provider.dart';

class EditTituloPage extends StatefulWidget {
  final Titulo titulo;
  const EditTituloPage({super.key, required this.titulo});

  @override
  State<EditTituloPage> createState() => _EditTituloPageState();
}

class _EditTituloPageState extends State<EditTituloPage> {
  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ano.text = widget.titulo.ano;
    _campeonato.text = widget.titulo.campeonato;
  }

  editar() {
    Provider.of<TimesRepository>(context, listen: false).editTitulo(
      titulo: widget.titulo,
      ano: _ano.text,
      campeonato: _campeonato.text,
    );

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Atualizado com sucesso!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Título'),
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(
            onPressed: editar,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                controller: _ano,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ano',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o ano do Título';
                  }
                  {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: TextFormField(
                controller: _campeonato,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Campeonato',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o campeonato';
                  }
                  {
                    return null;
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
