📚 Biblioteca Digital 
Este projeto é um aplicativo Flutter para gerenciamento de uma biblioteca digital, permitindo cadastro, edição, remoção e empréstimo de livros.

A aplicação foi estruturada de forma modular, com models, services, widgets e telas independentes.

🚀 Funcionalidades
📖 Gerenciar Livros: cadastrar, editar, remover e visualizar detalhes.

👥 Gerenciar Usuários: controle de quem pega emprestado.

📅 Gerenciar Empréstimos: registrar e encerrar empréstimos.

📊 Dashboard: resumo rápido de livros disponíveis, emprestados e total de usuários.

🔍 Pesquisa: localizar rapidamente um livro pelo título ou autor.

📂 Categorias: organização por tipo de livro.

🗂 Estrutura de Pastas
bash
Copiar
Editar
lib/
│── main.dart # Ponto de entrada do aplicativo
│
├── models/ # Modelos de dados
│ ├── livro.dart
│ ├── emprestimo.dart
│ └── usuario.dart
│
├── services/ # Lógica de negócio e dados
│ └── biblioteca_service.dart
│
├── widgets/ # Componentes reutilizáveis
│ ├── livro_widget.dart
│ ├── livro_ficcao_widget.dart
│ ├── formulario_widget.dart
│ └── formulario_livro_widget.dart
│
└── screens/ # Telas principais
├── dashboard_screen.dart
├── livros_screen.dart
├── emprestimos_screen.dart
└── usuarios_screen.dart
🛠 Modelos de Dados
Livro

Informações do livro (título, autor, ISBN, categoria, etc.)

Status (disponível ou emprestado)

Emprestimo

Relaciona um livro a um usuário

Datas de empréstimo e devolução

Status de atraso

Usuario

Dados do usuário (nome, e-mail, telefone)

Lista de empréstimos

