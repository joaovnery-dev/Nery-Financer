import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nery_financer_alpha/codigosBase/Transacao.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> adicionarTransacao(Transacao transacao) async {
    final userId = uid;

    if (userId == null || userId.isEmpty) {
      throw Exception('Usuário não autenticado. Faça login novamente.');
    }

    try {
      await firestore
          .collection('usuarios')
          .doc(userId)
          .collection('transacoes')
          .add(transacao.toMap());
    } on FirebaseException catch (e) {
      throw Exception('Erro ao salvar transação: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado ao salvar transação: $e');
    }
  }

  Stream<List<Transacao>> autualizarTransacoes() {
    final userId = uid;

    if (userId == null || userId.isEmpty) {
      return Stream.value([]);
    }

    return firestore
        .collection('usuarios')
        .doc(userId)
        .collection('transacoes')
        .orderBy('data', descending: true)
        .snapshots()
        .map((query) {
          return query.docs.map((doc) {
            return Transacao.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  Future<void> editarTransacao(Transacao transacao) async {
    final userId = uid;

    if (userId == null || userId.isEmpty) {
      throw Exception('Usuário não autenticado. Faça login novamente.');
    }

    try {
      await firestore
          .collection("usuarios")
          .doc(userId)
          .collection("transacoes")
          .doc(transacao.id)
          .update(transacao.toMap());
    } on FirebaseException catch (e) {
      throw Exception('Erro ao editar transação: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado ao editar transação: $e');
    }
  }

  Future<void> excluirTransacao(String id) async {
    final userId = uid;

    if (userId == null || userId.isEmpty) {
      throw Exception('Usuário não autenticado. Faça login novamente.');
    }

    try {
      await firestore
          .collection("usuarios")
          .doc(userId)
          .collection("transacoes")
          .doc(id)
          .delete();
    } on FirebaseException catch (e) {
      throw Exception('Erro ao excluir transação: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado ao excluir transação: $e');
    }
  }
}
