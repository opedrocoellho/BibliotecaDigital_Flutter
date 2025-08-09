import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/gerenciar_livros_screen.dart';
import 'screens/gerenciar_emprestimos_screen.dart';
import 'services/biblioteca_service.dart';

void main() => runApp(const BibliotecaApp());

class BibliotecaApp extends StatefulWidget {
  const BibliotecaApp({super.key});
  @override
  State<BibliotecaApp> createState() => _BibliotecaAppState();
}

class _BibliotecaAppState extends State<BibliotecaApp> {
  final service = BibliotecaService();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca Digital',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Biblioteca Digital')),
        body: IndexedStack(
          index: _index,
          children: [
            DashboardScreen(service: service),
            GerenciarLivrosScreen(service: service, onChanged: _refresh),
            GerenciarEmprestimosScreen(service: service, onChanged: _refresh),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Livros'),
            NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment), label: 'Empréstimos'),
          ],
        ),
      ),
    );
  }

  void _refresh() => setState(() {});
}
