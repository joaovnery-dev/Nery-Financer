import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nery_financer_alpha/servicos/firebase_options.dart';
import 'package:nery_financer_alpha/telas/tela_login.dart';
// Verifique se o caminho está correto

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    print("Erro ao inicializar Firebase: $e");
    // Isso ajudará a confirmar se o erro é falta de configuração no index.html
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TelaLogin());
  }
}
