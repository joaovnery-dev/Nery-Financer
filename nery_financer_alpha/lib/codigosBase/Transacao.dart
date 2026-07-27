import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nery_financer_alpha/codigosBase/Categoria.dart';
import 'package:nery_financer_alpha/codigosBase/tipoTransacao.dart';

class Transacao {
  String id;
  String titulo;
  String descricao;
  double valor;
  Categoria categoria;
  Tipo tipo;
  DateTime data;

  Transacao({
    this.id = '',
    required this.titulo,
    required this.descricao,
    required this.valor,
    required this.categoria,
    required this.tipo,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,

      'descricao': descricao,

      'valor': valor,

      'categoria': categoria.name,

      'tipo': tipo.name,

      'data': data,
    };
  }

  factory Transacao.fromMap(Map<String, dynamic> map, String id) {
    return Transacao(
      id: id,
      valor: map['valor'] ?? 0,
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      categoria: Categoria.values.firstWhere(
        (e) => e.name == map['categoria'],
        orElse: () => Categoria.outro,
      ),
      tipo: Tipo.values.firstWhere(
        (e) => e.name == map['tipo'],
        orElse: () => Tipo.despesa,
      ),
      data: (map['data'] as Timestamp).toDate() ?? DateTime.now(),
    );
  }
}
