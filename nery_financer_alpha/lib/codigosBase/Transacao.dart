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
    DateTime parseData(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is DateTime) {
        return value;
      }
      if (value is String) {
        try {
          return DateTime.parse(value);
        } catch (_) {
          return DateTime.now();
        }
      }
      return DateTime.now();
    }

    return Transacao(
      id: id,
      valor: (map['valor'] as num?)?.toDouble() ?? 0.0,
      titulo: map['titulo']?.toString() ?? '',
      descricao: map['descricao']?.toString() ?? '',
      categoria: Categoria.values.firstWhere(
        (e) => e.name == map['categoria'],
        orElse: () => Categoria.outro,
      ),
      tipo: Tipo.values.firstWhere(
        (e) => e.name == map['tipo'],
        orElse: () => Tipo.despesa,
      ),
      data: parseData(map['data']),
    );
  }
}
