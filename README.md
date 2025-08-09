# 📚 Biblioteca Digital 

Aplicativo Flutter para **gerenciamento de uma biblioteca digital**, permitindo cadastrar, editar, remover e emprestar livros.  
Possui dashboard com estatísticas, gerenciamento de empréstimos e navegação intuitiva.

---

## 🚀 Funcionalidades

- 📖 **Gerenciar Livros**: cadastrar, editar, remover e visualizar detalhes.
- 👥 **Gerenciar Usuários**: controle de quem pega emprestado.
- 📅 **Gerenciar Empréstimos**: registrar e encerrar empréstimos.
- 📊 **Dashboard**: resumo rápido de livros disponíveis, emprestados e total de usuários.
- 🔍 **Pesquisa**: localizar rapidamente um livro pelo título ou autor.
- 📂 **Categorias**: organização por tipo de livro.

---

## 🗂 Estrutura de Pastas

```
lib/
│── main.dart               # Ponto de entrada do aplicativo
│
├── models/                 # Modelos de dados
│   ├── livro.dart
│   ├── emprestimo.dart
│   └── usuario.dart
│
├── services/               # Lógica de negócio e dados
│   └── biblioteca_service.dart
│
├── widgets/                # Componentes reutilizáveis
│   ├── livro_widget.dart
│   ├── livro_ficcao_widget.dart
│   ├── formulario_widget.dart
│   └── formulario_livro_widget.dart
│
└── screens/                # Telas principais
    ├── dashboard_screen.dart
    ├── livros_screen.dart
    ├── emprestimos_screen.dart
    └── usuarios_screen.dart
```

---

## 💡 Fluxo de Uso

1. **Abrir o app** → Dashboard com resumo.
2. **Acessar "Livros"** → Adicionar ou editar.
3. **Acessar "Usuários"** → Registrar novos leitores.
4. **Fazer empréstimo** → Escolher livro + usuário.
5. **Registrar devolução** → Atualiza status e libera o livro.

---
