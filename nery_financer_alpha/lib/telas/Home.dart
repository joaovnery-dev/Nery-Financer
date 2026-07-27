import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nery_financer_alpha/codigosBase/Transacao.dart';
import 'package:nery_financer_alpha/codigosBase/tipoTransacao.dart';
import 'package:nery_financer_alpha/servicos/authService.dart';
import 'package:nery_financer_alpha/servicos/firestore_service.dart';
import 'package:nery_financer_alpha/telas/adicionarTransacao.dart';
import 'package:nery_financer_alpha/telas/tela_login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeEstado();
}

class HomeEstado extends State<Home> {
  final Authservice auth = Authservice();
  final FirestoreService fire = FirestoreService();
  final usuario = FirebaseAuth.instance.currentUser;

  String _formatarValor(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Future<void> _salvarEdicao(
    Transacao transacao,
    String novoTitulo,
    double novoValor,
    Tipo novoTipo,
  ) async {
    transacao.titulo = novoTitulo;
    transacao.valor = novoValor;
    transacao.tipo = novoTipo;

    await fire.editarTransacao(transacao);

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _editarTransacao(
    BuildContext context,
    Transacao transacao,
  ) async {
    final tituloController = TextEditingController(text: transacao.titulo);
    final valorController = TextEditingController(
      text: transacao.valor.toStringAsFixed(2).replaceAll('.', ','),
    );

    Tipo tipoSelecionado = transacao.tipo;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text(
            'Editar transação',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: valorController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Tipo>(
                value: tipoSelecionado,
                dropdownColor: const Color(0xFF1E293B),
                decoration: const InputDecoration(
                  labelText: 'Tipo',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: Tipo.receita,
                    child: Text(
                      'Receita',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DropdownMenuItem(
                    value: Tipo.despesa,
                    child: Text(
                      'Despesa',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    tipoSelecionado = value;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
              ),
              onPressed: () async {
                final novoTitulo = tituloController.text.trim();
                final novoValor = double.tryParse(
                  valorController.text.replaceAll(',', '.'),
                );

                if (novoTitulo.isEmpty || novoValor == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha título e valor corretamente'),
                    ),
                  );
                  return;
                }

                await _salvarEdicao(
                  transacao,
                  novoTitulo,
                  novoValor,
                  tipoSelecionado,
                );

                if (!context.mounted) return;
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Sair',
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFF1E293B),
                    title: const Text(
                      'Sair',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      'Você quer sair?',
                      style: TextStyle(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Não'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                        ),
                        onPressed: () {
                          auth.logout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaLogin(),
                            ),
                          );
                        },
                        child: const Text('Sim'),
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout != true) return;

              await auth.logout();

              if (!mounted) return;

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            icon: const CircleAvatar(
              backgroundColor: Color(0xFF3B82F6),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3B82F6),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Adicionartransacao()),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: const Color(0xFF0F172A),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "👋 ola ${usuario?.displayName ?? 'usuário'}",
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Bem-vindo ao Nery Financer",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 60),

                Container(
                  height: 140,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "💰 Saldo Total",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<List<Transacao>>(
                        stream: fire.autualizarTransacoes(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Text(
                              "R\$ 0,00",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }

                          final transacoes = snapshot.data!;
                          final totalEntradas = transacoes
                              .where((t) => t.tipo == Tipo.receita)
                              .fold<double>(0, (sum, t) => sum + t.valor);
                          final totalSaidas = transacoes
                              .where((t) => t.tipo != Tipo.receita)
                              .fold<double>(0, (sum, t) => sum + t.valor);
                          final saldo = totalEntradas - totalSaidas;

                          return Text(
                            _formatarValor(saldo),
                            style: TextStyle(
                              color: saldo >= 0
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                StreamBuilder<List<Transacao>>(
                  stream: fire.autualizarTransacoes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E293B),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "📈 Entradas",
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "R\$ 0,00",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E293B),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "📉 Saídas",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "R\$ 0,00",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    final transacoes = snapshot.data!;
                    final totalEntradas = transacoes
                        .where((t) => t.tipo == Tipo.receita)
                        .fold<double>(0, (sum, t) => sum + t.valor);
                    final totalSaidas = transacoes
                        .where((t) => t.tipo != Tipo.receita)
                        .fold<double>(0, (sum, t) => sum + t.valor);

                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "📈 Entradas",
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  _formatarValor(totalEntradas),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "📉 Saídas",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  _formatarValor(totalSaidas),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 80),

                StreamBuilder<List<Transacao>>(
                  stream: fire.autualizarTransacoes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Erro ao carregar transações",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final transacoes = snapshot.data!;

                    if (transacoes.isEmpty) {
                      return const Center(
                        child: Text(
                          "Nenhuma transação cadastrada",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transacoes.length,
                      itemBuilder: (context, index) {
                        final transacao = transacoes[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.20),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: transacao.tipo == Tipo.receita
                                      ? Colors.green.withOpacity(0.20)
                                      : Colors.red.withOpacity(0.20),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  transacao.tipo == Tipo.receita
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: transacao.tipo == Tipo.receita
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      transacao.titulo,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      transacao.categoria.name,
                                      style: const TextStyle(
                                        color: Colors.white60,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${transacao.data.day.toString().padLeft(2, '0')}/${transacao.data.month.toString().padLeft(2, '0')}/${transacao.data.year}",
                                      style: const TextStyle(
                                        color: Colors.white38,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    transacao.tipo == Tipo.receita
                                        ? "+ R\$ ${transacao.valor.toStringAsFixed(2)}"
                                        : "- R\$ ${transacao.valor.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: transacao.tipo == Tipo.receita
                                          ? Colors.greenAccent
                                          : Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Icon(
                                    transacao.tipo == Tipo.receita
                                        ? Icons.trending_up
                                        : Icons.trending_down,
                                    color: transacao.tipo == Tipo.receita
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                  ),
                                  const SizedBox(height: 6),
                                  IconButton(
                                    onPressed: () =>
                                        _editarTransacao(context, transacao),
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white70,
                                      size: 20,
                                    ),
                                    tooltip: 'Editar transação',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
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
