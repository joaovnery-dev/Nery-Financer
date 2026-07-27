import 'package:flutter/material.dart';
import 'package:nery_financer_alpha/camporReutilizaveis/TextField.dart';
import 'package:nery_financer_alpha/camporReutilizaveis/botao.dart';
import 'package:nery_financer_alpha/servicos/authService.dart';

class Cadastro extends StatefulWidget {
  @override
  State<Cadastro> createState() => estado();
}

class estado extends State<Cadastro> {
  Authservice auth = Authservice();
  String erro = "";
  ///////////
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController confirme = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      floatingActionButton: Align(
        alignment: Alignment.topLeft, // Canto Superior Esquerdo
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Distância segura das bordas
          child: IconButton(
            icon: const Icon(Icons.logout, color: Colors.white70),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      // Confirmação antes de sair é uma boa prática
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120),
              Text(
                "Bem vindo a tela de cadastro!",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(height: 50),
              Texto(
                corTexto: Colors.white,
                controller: nome,
                labelText: "Nome",
                hintText: "Digite seu nome ",
                enabled: true,
                isPassword: false,
              ),
              SizedBox(height: 25),
              Texto(
                corTexto: Colors.white,
                controller: email,
                labelText: "Email",
                hintText: "Digite seu Email ",
                enabled: true,
                isPassword: false,
              ),
              SizedBox(height: 25),
              Texto(
                corTexto: Colors.white,
                controller: senha,
                labelText: "Senha",
                hintText: "Digite sua senha ",
                enabled: true,
                isPassword: false,
              ),
              SizedBox(height: 25),
              Texto(
                corTexto: Colors.white,
                controller: confirme,
                labelText: "Confirme sua senha",
                hintText: "Digite sua senha novamente ",
                enabled: true,
                isPassword: true,
              ),
              SizedBox(height: 30),
              Botao(
                texto: "Cadastrar",
                corTexto: Colors.white,
                tamanhoTexto: 20,
                corBotao: Colors.black,
                tamanhoAltura: 60,
                tamanhoLargura: 160,
                onpressed: () async {
                  if (senha.text.isEmpty ||
                      confirme.text.isEmpty ||
                      nome.text.isEmpty ||
                      email.text.isEmpty) {
                    setState(() {
                      erro = "Preenha todos os campos";
                    });
                  } else if (senha.text != confirme.text) {
                    setState(() {
                      erro = "As senhas nao coincidem";
                    });
                  } else {
                    if (senha.text.isEmpty ||
                        confirme.text.isEmpty ||
                        nome.text.isEmpty ||
                        email.text.isEmpty) {
                      setState(() {
                        erro = "Preenha todos os campos";
                      });
                    } else if (senha.text != confirme.text) {
                      setState(() {
                        erro = "As senhas nao coincidem";
                      });
                    } else {
                      final cadas = await auth.criarConta(
                        email.text,
                        nome.text,
                        senha.text,
                      );

                      if (cadas == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Conta criada"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        await Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pop(context);
                        });
                        //conta criada
                      } else {
                        setState(() {
                          erro = auth.error;
                        });
                      }
                    }
                  }
                },
              ),
              SizedBox(height: 10),
              Text(erro, style: TextStyle(color: Colors.red, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
