import 'emprestimo.dart';
class Usuario {
  int? id; final String nome; final String email; final String telefone; final DateTime dataCadastro; bool ativo; List<Emprestimo> emprestimos;
  Usuario({this.id, required this.nome, required this.email, this.telefone = '', DateTime? dataCadastro, this.ativo = true, List<Emprestimo>? emprestimos})
    : dataCadastro = dataCadastro ?? DateTime.now(), emprestimos = emprestimos ?? [];
  bool get temEmprestimosAtivos => emprestimos.any((e) => e.ativo);
  bool get temEmprestimosAtrasados => emprestimos.any((e) => e.estaAtrasado);
}
