import 'package:flutter/material.dart';
import '../services/biblioteca_service.dart';

class DashboardScreen extends StatelessWidget {
  final BibliotecaService service;
  const DashboardScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Resumo', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _stat(context, 'Livros', service.totalLivros, Icons.menu_book),
          _stat(context, 'Disponíveis', service.totalDisponiveis, Icons.fact_check),
          _stat(context, 'Emprestados', service.totalEmprestados, Icons.hourglass_top),
          _stat(context, 'Empréstimos ativos', service.totalEmprestimosAtivos, Icons.assignment),
        ]),
      ],
    );
  }

  Widget _stat(BuildContext ctx, String titulo, int valor, IconData icone) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icone, size: 28),
        const SizedBox(height: 8),
        Text('$valor', style: Theme.of(ctx).textTheme.headlineSmall),
        Text(titulo),
      ]),
    ),
  );
}
