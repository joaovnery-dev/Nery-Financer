import 'package:flutter_test/flutter_test.dart';
import 'package:nery_financer_alpha/codigosBase/Categoria.dart';
import 'package:nery_financer_alpha/codigosBase/Transacao.dart';
import 'package:nery_financer_alpha/codigosBase/tipoTransacao.dart';

void main() {
  group('Transacao.fromMap', () {
    test('aceita datas armazenadas como DateTime', () {
      final data = DateTime(2024, 1, 2, 3, 4, 5);

      final transacao = Transacao.fromMap({
        'valor': 15.5,
        'titulo': 'Salário',
        'descricao': 'Pagamento',
        'categoria': 'alimentacao',
        'tipo': 'receita',
        'data': data,
      }, 'abc123');

      expect(transacao.titulo, 'Salário');
      expect(transacao.valor, 15.5);
      expect(transacao.categoria, Categoria.alimentacao);
      expect(transacao.tipo, Tipo.receita);
      expect(transacao.data, data);
    });
  });
}
