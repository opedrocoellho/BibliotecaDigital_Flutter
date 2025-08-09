import 'package:flutter/material.dart';
import '../../models/livro.dart';
import 'formulario_widget.dart';

class FormularioLivroWidget extends FormularioWidget {
  final Livro? livroParaEdicao;
  final void Function(Livro) onSalvar;
  final VoidCallback? onCancelar;
  const FormularioLivroWidget({super.key, this.livroParaEdicao, required this.onSalvar, this.onCancelar});

  @override
  State<FormularioLivroWidget> createState() => _FormularioLivroWidgetState();
}

class _FormularioLivroWidgetState extends FormularioWidgetState<FormularioLivroWidget> {
  final _formKey = GlobalKey<FormState>();
  late String _titulo, _autor, _isbn, _categoria, _descricao;
  late int _anoPublicacao;
  bool _disponivel = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final l = widget.livroParaEdicao;
    _titulo = l?.titulo ?? '';
    _autor = l?.autor ?? '';
    _isbn = l?.isbn ?? '';
    _anoPublicacao = l?.anoPublicacao ?? DateTime.now().year;
    _categoria = l?.categoria ?? '';
    _disponivel = l?.disponivel ?? true;
    _descricao = l?.descricao ?? '';
  }

  @override
  bool validar() => _formKey.currentState?.validate() ?? false;

  @override
  void limpar() {
    setState(() {
      _titulo = _autor = _isbn = _categoria = _descricao = '';
      _anoPublicacao = DateTime.now().year;
      _disponivel = true;
      _formKey.currentState?.reset();
    });
  }

  @override
  Future<void> salvar() async {
    if (!validar()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 400));
    final livro = Livro(
      id: widget.livroParaEdicao?.id,
      titulo: _titulo,
      autor: _autor,
      isbn: _isbn,
      anoPublicacao: _anoPublicacao,
      categoria: _categoria,
      disponivel: _disponivel,
      dataCadastro: widget.livroParaEdicao?.dataCadastro,
      descricao: _descricao,
    );
    widget.onSalvar(livro);
    setState(() => _loading = false);
    if (widget.livroParaEdicao == null) limpar();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.livroParaEdicao == null ? 'Cadastrar Novo Livro' : 'Editar Livro', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: _titulo,
              decoration: const InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.isEmpty) ? 'Informe o título' : null,
              onChanged: (v) => _titulo = v,
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: _autor,
              decoration: const InputDecoration(labelText: 'Autor', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.isEmpty) ? 'Informe o autor' : null,
              onChanged: (v) => _autor = v,
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: TextFormField(
                  initialValue: _isbn,
                  decoration: const InputDecoration(labelText: 'ISBN', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'Informe o ISBN' : null,
                  onChanged: (v) => _isbn = v,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue: _anoPublicacao.toString(),
                  decoration: const InputDecoration(labelText: 'Ano', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    final ano = int.tryParse(v ?? '');
                    if (ano == null || ano < 1000 || ano > 2100) return 'Ano inválido';
                    return null;
                  },
                  onChanged: (v) { final a = int.tryParse(v); if (a != null) _anoPublicacao = a; },
                ),
              ),
            ]),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _categoria.isNotEmpty ? _categoria : null,
              decoration: const InputDecoration(labelText: 'Categoria', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'Ficção', child: Text('Ficção')),
                DropdownMenuItem(value: 'Técnico', child: Text('Técnico')),
                DropdownMenuItem(value: 'Acadêmico', child: Text('Acadêmico')),
                DropdownMenuItem(value: 'Biografia', child: Text('Biografia')),
              ],
              validator: (v) => (v == null || v.isEmpty) ? 'Selecione uma categoria' : null,
              onChanged: (v) => setState(() => _categoria = v ?? ''),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: _disponivel,
              title: const Text('Disponível para empréstimo'),
              onChanged: (v) => setState(() => _disponivel = v),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: _descricao,
              decoration: const InputDecoration(labelText: 'Descrição', border: OutlineInputBorder(), alignLabelWithHint: true),
              maxLines: 3,
              onChanged: (v) => _descricao = v,
            ),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(onPressed: _loading ? null : limpar, child: const Text('Limpar')),
              const SizedBox(width: 8),
              FilledButton(onPressed: _loading ? null : salvar, child: Text(_loading ? 'Salvando...' : (widget.livroParaEdicao == null ? 'Cadastrar' : 'Atualizar'))),
              if (widget.onCancelar != null) ...[const SizedBox(width: 8), TextButton(onPressed: widget.onCancelar, child: const Text('Cancelar'))],
            ]),
          ]),
        ),
      ),
    );
  }
}
