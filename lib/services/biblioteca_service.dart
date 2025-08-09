import '../models/livro.dart';
import '../models/emprestimo.dart';

class BibliotecaService {
  final List<Livro> _livros = [];
  final List<Emprestimo> _emprestimos = [];
  int _livroId = 1;
  int _empId = 1;

  BibliotecaService() {
    // Seed de 2 livros
    adicionarLivro(Livro(
      titulo: 'O Senhor dos Anéis',
      autor: 'J.R.R. Tolkien',
      isbn: '9780544003415',
      anoPublicacao: 1954,
      categoria: 'Ficção',
      descricao: 'Trilogia épica de fantasia na Terra Média.',
    ));
    adicionarLivro(Livro(
      titulo: 'Clean Code',
      autor: 'Robert C. Martin',
      isbn: '9780132350884',
      anoPublicacao: 2008,
      categoria: 'Técnico',
      descricao: 'Práticas para escrever código limpo.',
    ));
  }

  List<Livro> get livros => List.unmodifiable(_livros);
  List<Emprestimo> get emprestimos => List.unmodifiable(_emprestimos);

  Livro adicionarLivro(Livro livro) {
    final novo = livro.copyWith(id: _livroId++);
    _livros.add(novo);
    return novo;
  }

  void atualizarLivro(Livro livro) {
    final i = _livros.indexWhere((l) => l.id == livro.id);
    if (i != -1) _livros[i] = livro;
  }

  void removerLivro(Livro livro) {
    _livros.removeWhere((l) => l.id == livro.id);
    _emprestimos.removeWhere((e) => e.livroId == livro.id);
  }

  Emprestimo registrarEmprestimo({
    required Livro livro,
    required String nomeUsuario,
    required String emailUsuario,
    DateTime? dataPrevistaDevolucao,
    String observacoes = '',
  }) {
    if (!livro.disponivel) throw Exception('Livro indisponível para empréstimo.');
    final emp = Emprestimo(
      id: _empId++,
      livroId: livro.id!,
      livro: livro,
      nomeUsuario: nomeUsuario,
      emailUsuario: emailUsuario,
      dataPrevistaDevolucao: dataPrevistaDevolucao,
      observacoes: observacoes,
    );
    _emprestimos.add(emp);
    _marcarDisponibilidade(livro, false);
    return emp;
  }

  void registrarDevolucao(Emprestimo emp) {
    final i = _emprestimos.indexWhere((e) => e.id == emp.id);
    if (i != -1) {
      _emprestimos[i].ativo = false;
      _emprestimos[i].dataDevolucao = DateTime.now();
      _marcarDisponibilidade(_emprestimos[i].livro, true);
    }
  }

  List<Emprestimo> historicoDoLivro(Livro livro) =>
      _emprestimos.where((e) => e.livroId == livro.id).toList();

  void _marcarDisponibilidade(Livro livro, bool disponivel) {
    final i = _livros.indexWhere((l) => l.id == livro.id);
    if (i != -1) _livros[i] = _livros[i].copyWith(disponivel: disponivel);
  }

  // Estatísticas
  int get totalLivros => _livros.length;
  int get totalDisponiveis => _livros.where((l) => l.disponivel).length;
  int get totalEmprestados => _livros.where((l) => !l.disponivel).length;
  int get totalEmprestimosAtivos => _emprestimos.where((e) => e.ativo).length;
}
