import 'package:flutter/material.dart';
import '../services/biblioteca_service.dart';
import '../models/livro.dart';
import '../models/emprestimo.dart';

class GerenciarEmprestimosScreen extends StatefulWidget {
  final BibliotecaService service;
  final VoidCallback onChanged;
  const GerenciarEmprestimosScreen({super.key, required this.service, required this.onChanged});

  @override
  State<GerenciarEmprestimosScreen> createState() => _GerenciarEmprestimosScreenState();
}

class _GerenciarEmprestimosScreenState extends State<GerenciarEmprestimosScreen> {
  Livro? _livro;
  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final disponiveis = widget.service.livros.where((l) => l.disponivel).toList();
    final emprestimos = widget.service.emprestimos;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          const Text('Registrar Empréstimo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [
          Expanded(
            child: DropdownButton<Livro>(
              isExpanded: true,
              hint: const Text('Escolha um livro'),
              value: _livro,
              items: disponiveis.map((l) => DropdownMenuItem(value: l, child: Text(l.titulo))).toList(),
              onChanged: (v) => setState(() => _livro = v),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: TextField(controller: _nomeCtrl, decoration: const InputDecoration(labelText: 'Nome'))),
          const SizedBox(width: 8),
          Expanded(child: TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email'))),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () {
              if (_livro == null || _nomeCtrl.text.isEmpty || !_emailCtrl.text.contains('@')) return;
              try {
                widget.service.registrarEmprestimo(livro: _livro!, nomeUsuario: _nomeCtrl.text, emailUsuario: _emailCtrl.text);
                _livro = null; _nomeCtrl.clear(); _emailCtrl.clear();
                setState(() {}); widget.onChanged();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: const Text('Emprestar'),
          ),
        ]),
      ),
      const Divider(height: 24),
      Expanded(
        child: ListView.builder(
          itemCount: emprestimos.length,
          itemBuilder: (_, i) {
            final e = emprestimos[i];
            return ListTile(
              leading: Icon(e.estaAtrasado ? Icons.warning_amber : Icons.book),
              title: Text(e.livro.titulo),
              subtitle: Text('Para: ${e.nomeUsuario} • Prevista: ${e.dataPrevistaDevolucao.day}/${e.dataPrevistaDevolucao.month}/${e.dataPrevistaDevolucao.year}'),
              trailing: e.ativo
                  ? FilledButton(onPressed: () { widget.service.registrarDevolucao(e); setState(() {}); widget.onChanged(); }, child: const Text('Devolver'))
                  : const Chip(label: Text('Devolvido')),
            );
          },
        ),
      ),
    ]);
  }
}
