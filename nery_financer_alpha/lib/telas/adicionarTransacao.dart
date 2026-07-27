import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nery_financer_alpha/camporReutilizaveis/TextField.dart';
import 'package:nery_financer_alpha/camporReutilizaveis/botao.dart';
import 'package:nery_financer_alpha/codigosBase/Categoria.dart';
import 'package:nery_financer_alpha/codigosBase/Transacao.dart';
import 'package:nery_financer_alpha/codigosBase/tipoTransacao.dart';
import 'package:nery_financer_alpha/servicos/firestore_service.dart';
import 'package:nery_financer_alpha/telas/Home.dart';

class Adicionartransacao extends StatefulWidget {
  @override
  State<Adicionartransacao> createState() => estado();
}

String nomeCategoria(Categoria categoria) {
  switch (categoria) {
    case Categoria.alimentacao:
      return "🍔 Alimentação";

    case Categoria.transporte:
      return "🚗 Transporte";

    case Categoria.moradia:
      return "🏠 Moradia";

    case Categoria.lazer:
      return "🎮 Lazer";

    case Categoria.saude:
      return "❤️ Saúde";

    case Categoria.outro:
      return "📦 Outro";
  }
}

String tipoValor(Tipo tipo) {
  switch (tipo) {
    case Tipo.despesa:
      return "🟥Despesa";
    case Tipo.receita:
      return "🟢Receita";
  }
}

class estado extends State<Adicionartransacao> {
  TextEditingController nome = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController valor = TextEditingController();

  FirestoreService fire = FirestoreService();
  ////////
  Categoria categoria = Categoria.alimentacao;
  Tipo tipoatual = Tipo.despesa;
  @override
  void dispose() {
    nome.dispose();
    descricao.dispose();
    valor.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0F172A),
        onPressed: () {
          Navigator.pop(context);
        },

        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "💰 Adicione uma nova movimentação",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),

                SizedBox(height: 120),

                Texto(
                  corTexto: Colors.white,
                  controller: nome,
                  labelText: "Nome da transacação",
                  hintText: "Digite o nome da transação",
                  enabled: true,
                  isPassword: false,
                ),
                SizedBox(height: 30),
                Texto(
                  corTexto: Colors.white,
                  controller: descricao,
                  labelText: "digite a descricao da transacao",
                  hintText: "Digite a descricao",
                  enabled: true,
                  isPassword: false,
                ),
                SizedBox(height: 30),
                Texto(
                  controller: valor,
                  labelText: "Valor",
                  hintText: "Digite o valor",
                  enabled: true,
                  isPassword: false,
                  corTexto: Colors.white,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                ),

                SizedBox(height: 40),

                DropdownButtonFormField<Categoria>(
                  //aqui eu estou fazendo o formato do meu botao e que ele possua o meu enum categoria
                  value: categoria, //o meu valor atual e a da minha categoria
                  dropdownColor: Colors.black, //aqui a cor dele fica preta

                  decoration: InputDecoration(
                    //decoracao
                    labelText: "Categoria", //texto categoria em cima da box
                    border: OutlineInputBorder(
                      //decoracao para o deixar mais circular
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  items: Categoria.values.map((categoria) {
                    //aqui temos os itens que iremos colocar os valores da minha categoria em formato de map
                    return DropdownMenuItem(
                      //quando clicamos ele retorna a lista dele
                      value:
                          categoria, //aonde aparece todos os tipos de categoria que acessamos pelo map

                      child: Text(
                        nomeCategoria(
                          categoria,
                        ), //aqui colocamos o nome dela junto ao emoji
                        style: TextStyle(color: Colors.white), //cor branca
                      ),
                    );
                  }).toList(), //e os tranformamos em uma lista ja que e uma lista de categorias

                  onChanged: (novaCategoria) {
                    //quando mudamos nossa categoria vira a nova categoria que nunca pode ser nula
                    setState(() {
                      categoria = novaCategoria!;
                    });
                  },
                ),

                SizedBox(height: 30),
                DropdownButtonFormField<Tipo>(
                  value: tipoatual,
                  dropdownColor: Colors.black,
                  decoration: InputDecoration(
                    //decoracao
                    labelText: "Tipo da sua transacao",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  items: Tipo.values.map((tipo) {
                    return DropdownMenuItem(
                      value: tipo,

                      child: Text(
                        tipoValor(tipo),
                        style: TextStyle(color: Colors.white), //cor branca
                      ),
                    );
                  }).toList(),

                  onChanged: (novotipo) {
                    setState(() {
                      tipoatual = novotipo!;
                    });
                  },
                ),
                SizedBox(height: 40),

                Botao(
                  texto: "Salvar",
                  corTexto: Colors.white,
                  tamanhoTexto: 30,
                  corBotao: Colors.black,
                  tamanhoAltura: 80,
                  tamanhoLargura: 180,
                  onpressed: () async {
                    if (nome.text.isEmpty ||
                        descricao.text.isEmpty ||
                        valor.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Preencha todos os campos"),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    try {
                      await fire.adicionarTransacao(
                        Transacao(
                          titulo: nome.text,
                          descricao: descricao.text,
                          valor: double.parse(valor.text.replaceAll(',', '.')),
                          categoria: categoria,
                          tipo: tipoatual,
                          data: DateTime.now(),
                        ),
                      );

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Transação adicionada!"),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.pop(context);
                    } catch (e) {
                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
