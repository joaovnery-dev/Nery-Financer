import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Texto extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;

  final String labelText;
  final String? hintText;
  final bool enabled;
  final Color corTexto;
  final TextEditingController? controller;
  // 1. Novo parâmetro para definir se é senha
  final bool isPassword;

  const Texto({
    super.key,
    required this.corTexto,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.enabled,
    required this.isPassword, // Padrão é false (não é senha)
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<Texto> createState() => _TextoState();
}

class _TextoState extends State<Texto> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      // 2. Só esconde o texto se for password E a variável estiver true
      obscureText: _obscureText,
      enabled: widget.enabled,
      style: TextStyle(color: widget.corTexto),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),

        // 3. O ícone só aparece se for password E estiver habilitado
        suffixIcon: (widget.isPassword && widget.enabled)
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: widget.corTexto,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
