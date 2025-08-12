import 'livro.dart';
class Emprestimo {
  int? id;
  final int livroId;
  final Livro livro;
  final String nomeUsuario;
  final String emailUsuario;
  final DateTime dataEmprestimo;
  final DateTime dataPrevistaDevolucao;
  DateTime? dataDevolucao;
  bool ativo;
  final String observacoes;
  Emprestimo({
    this.id,
    required this.livroId,
    required this.livro,
    required this.nomeUsuario,
    required this.emailUsuario,
    DateTime? dataEmprestimo,
    DateTime? dataPrevistaDevolucao,
    this.dataDevolucao,
    this.ativo = true,
    this.observacoes = '',
  })  : dataEmprestimo = dataEmprestimo ?? DateTime.now(),
        dataPrevistaDevolucao = dataPrevistaDevolucao ?? DateTime.now().add(const Duration(days: 15));
  bool get estaAtrasado => ativo && dataDevolucao == null && DateTime.now().isAfter(dataPrevistaDevolucao);
  int get diasRestantes => (!ativo || dataDevolucao != null) ? 0 : dataPrevistaDevolucao.difference(DateTime.now()).inDays;
}
