import 'package:flutter/material.dart';
abstract class FormularioWidget extends StatefulWidget {
  const FormularioWidget({super.key});
}
abstract class FormularioWidgetState<T extends FormularioWidget> extends State<T> {
  Future<void> salvar();
  void limpar();
  bool validar();
}
