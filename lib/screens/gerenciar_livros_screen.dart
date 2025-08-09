import 'package:flutter/material.dart';
import '../services/biblioteca_service.dart';
import '../models/livro.dart';
import '../widgets/formularios/formulario_livro_widget.dart';

class GerenciarLivrosScreen extends StatefulWidget {
  final BibliotecaService service;
  final VoidCallback onChanged;
  const GerenciarLivrosScreen({super.key, required this.service, required this.onChanged});

  @override
  State<GerenciarLivrosScreen> createState() => _GerenciarLivrosScreenState();
}

class _GerenciarLivrosScreenState extends State<GerenciarLivrosScreen> {
  void _abrirFormulario([Livro? livro]) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: FormularioLivroWidget(
          livroParaEdicao: livro,
          onSalvar: (novo) {
            if (novo.id == null) {
              widget.service.adicionarLivro(novo);
            } else {
              widget.service.atualizarLivro(novo);
            }
            setState(() {});
            widget.onChanged();
            Navigator.pop(context);
          },
          onCancelar: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final livros = widget.service.livros;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          const Text('Livros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          FilledButton.icon(onPressed: () => _abrirFormulario(), icon: const Icon(Icons.add), label: const Text('Novo Livro')),
        ]),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: livros.length,
          itemBuilder: (_, i) {
            final l = livros[i];
            return ListTile(
              title: Text(l.titulo),
              subtitle: Text('${l.autor} • ${l.categoria} • ${l.anoPublicacao}'),
              trailing: Wrap(spacing: 8, children: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () => _abrirFormulario(l)),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {
                  widget.service.removerLivro(l);
                  setState(() {});
                  widget.onChanged();
                }),
              ]),
            );
          },
        ),
      ),
    ]);
  }
}
