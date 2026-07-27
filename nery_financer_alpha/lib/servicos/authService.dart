import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  String error = "";
  final FirebaseAuth _auth = FirebaseAuth
      .instance; //instanciamos o auth para podermos usar seus metodos
  final FirebaseFirestore fire = FirebaseFirestore.instance;

  Future<String?> criarConta(String email, String nome, String senha) async {
    try {
      UserCredential usuario = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      await usuario.user!.updateDisplayName(nome);

      final uid = usuario.user!.uid;

      await fire.collection('usuarios').doc(uid).set({
        'nome': nome,
        'email': email,
      });

      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return "A senha é muito fraca. Use pelo menos 6 caracteres.";

        case 'email-already-in-use':
          return "Este e-mail já está cadastrado.";

        case 'invalid-email':
          return "O formato do e-mail é inválido.";

        case 'operation-not-allowed':
          return "Login com e-mail/senha não está habilitado no Firebase.";

        case 'user-disabled':
          return "Esta conta de usuário foi desativada.";

        case 'too-many-requests':
          return "Muitas tentativas. Tente novamente mais tarde.";

        default:
          return "Erro: ${e.message}";
      }
    } on FirebaseException catch (e) {
      return "Erro no Firestore: ${e.message}";
    } catch (e) {
      return "Erro inesperado: $e";
    }
  }

  Future<String?> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      error = "";
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
          // Por segurança, o Firebase muitas vezes agrupa esses erros como 'invalid-credential'
          error = "E-mail ou senha incorretos.";
          break;

        case 'user-disabled':
          error = "Esta conta foi desativada.";
          break;

        case 'invalid-email':
          error = "E-mail inválido.";
          break;

        case 'too-many-requests':
          error = "Muitas tentativas. Tente novamente mais tarde.";
          break;

        case 'operation-not-allowed':
          error = "Método de login não habilitado.";
          break;

        default:
          error = "Erro: ${e.message}";
          break;
      }
      return error;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? usuarioAtual() {
    //metodo user salva nome senha e email ou seja aqui esta salvando no meu usuario

    return _auth.currentUser;
  }
}
