import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final Color corBotao;
  final double tamanhoTexto;
  final Color corTexto;
  final double tamanhoAltura;
  final double tamanhoLargura;
  final VoidCallback onpressed;

  const Botao({
    required this.texto,
    required this.corTexto,
    required this.tamanhoTexto,
    required this.corBotao,
    required this.tamanhoAltura,
    required this.tamanhoLargura,
    required this.onpressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: corTexto,
        backgroundColor: corBotao,
        fixedSize: Size(tamanhoLargura, tamanhoAltura),
      ),
      child: Text(texto, style: TextStyle(fontSize: tamanhoTexto)),
    );
  }
}
