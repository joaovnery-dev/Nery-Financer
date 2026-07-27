import 'package:flutter/material.dart';
import 'package:nery_financer_alpha/camporReutilizaveis/TextField.dart';
import 'package:nery_financer_alpha/camporReutilizaveis/botao.dart';
import 'package:nery_financer_alpha/servicos/authService.dart';
import 'package:nery_financer_alpha/telas/Home.dart';
import 'package:nery_financer_alpha/telas/cadastro.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  Authservice auth = Authservice();
  // Correção essencial: Controladores fora do build para não perder dados
  late final TextEditingController emailController;
  late final TextEditingController senhaController;

  //teto de erro
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    senhaController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Fundo Azul Noite
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ícone maior e com destaque
              const Text("💳", style: TextStyle(fontSize: 60)),

              const SizedBox(height: 30),

              // Título Moderno
              const Text(
                "Nery Financer",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 10),

              // Subtítulo com cor suave
              Text(
                "controle todas as suas finanças",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              // Campo Email (Corrigido: enabled true e label correto)
              Texto(
                isPassword: false,
                controller: emailController,
                labelText: "Email",
                hintText: "Digite seu email",
                enabled: true,
                corTexto: Colors.white,
              ),

              const SizedBox(height: 20),

              // Campo Senha
              Texto(
                isPassword: true,
                controller: senhaController,
                labelText: "Senha",
                hintText: "Mínimo 8 dígitos",
                enabled: true,
                corTexto: Colors.white,
              ),

              const SizedBox(height: 40),

              // Botão Principal Estilizado
              Botao(
                texto: "LOGAR",
                corTexto: Colors.white,
                tamanhoTexto: 16, // Texto maior
                corBotao: const Color.fromARGB(255, 0, 0, 0), // Azul moderno
                tamanhoAltura: 55, // Botão mais alto e confortável
                tamanhoLargura: double.infinity, // Ocupa a largura disponível
                // Correção: Função anônima para não executar ao carregar
                onpressed: () async {
                  if (emailController.text.isEmpty ||
                      senhaController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Preencha todos os campos"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ),
                    );
                    return; // Interrompe a execução para não tentar logar
                  }
                  await auth.login(emailController.text, senhaController.text);

                  if (auth.error == "") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(auth.error),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(
                          label: "OK",
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    );
                  }

                  // Ação de logar
                  // Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),

              // Botão de Cadastro (Texto simples)
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cadastro()),
                  );
                },
                child: Text(
                  "Não tem conta? Cadastre-se",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
