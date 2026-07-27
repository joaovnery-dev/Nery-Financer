![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Cloud_Firestore-FFCA28?logo=firebase)
![License](https://img.shields.io/badge/license-MIT-green)
<p align="center">
<img src="assets/logo.png" width="180">
</p>
# 💰 Nery Financer

O **Nery Financer** é um aplicativo de controle financeiro desenvolvido em Flutter com Firebase.

Criei esse projeto para colocar em prática os conhecimentos que fui aprendendo durante meus estudos, principalmente Flutter, Firebase e Programação Orientada a Objetos. Durante o desenvolvimento, procurei entender o funcionamento de cada parte do aplicativo em vez de apenas fazer tudo funcionar.

Cada usuário possui sua própria conta e consegue cadastrar receitas e despesas, que ficam armazenadas no Cloud Firestore e são atualizadas em tempo real.

---

## 🚀 Diferencial

Mais do que um aplicativo funcionando, este projeto foi desenvolvido com o objetivo de aprofundar conceitos importantes do desenvolvimento mobile.

Durante o desenvolvimento trabalhei com:

- Autenticação de usuários utilizando Firebase Authentication;
- Banco de dados em tempo real com Cloud Firestore;
- CRUD completo (Criar, Ler, Atualizar e Excluir);
- Atualização automática da interface utilizando **Streams** e **StreamBuilder**;
- Conversão entre objetos Dart e documentos do Firestore (`toMap()` e `fromMap()`);
- Organização do código em camadas (Telas, Serviços, Modelos e Widgets reutilizáveis);
- Programação Orientada a Objetos aplicada em um projeto real.

Todo o projeto foi desenvolvido como forma de aprendizado, buscando compreender cada tecnologia utilizada e não apenas reproduzir código.

---

# ✨ Funcionalidades

- Cadastro de usuários
- Login
- Logout
- Cadastro de receitas
- Cadastro de despesas
- Atualização automática da lista de transações
- Organização das transações por usuário
- Categorias para cada movimentação
- Interface responsiva
- Widgets reutilizáveis

---

# 🛠 Tecnologias

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Material Design

---

# 📂 Estrutura do projeto

```text
lib
│
├── camporReutilizaveis
├── codigosBase
├── servicos
├── telas
└── main.dart
```

---

# 🔥 Banco de Dados

O projeto utiliza o Cloud Firestore.

Estrutura utilizada:

```text
usuarios
 └── uid
      ├── nome
      ├── email
      └── transacoes
            ├── documento
            ├── documento
            └── ...
```

Cada usuário possui sua própria coleção de transações, garantindo que seus dados fiquem separados dos demais usuários.

---

# 📸 Imagens

## Login

*(adicione uma imagem)*

## Home

*(adicione uma imagem)*

## Nova transação

*(adicione uma imagem)*

---

# ▶ Como executar

```bash
git clone https://github.com/joaovnery-dev/Nery_Financer.git
```

```bash
flutter pub get
```

```bash
flutter run
```

---

# 📌 Próximas melhorias

- Editar transações
- Pesquisa por transações
- Filtro por categoria
- Relatórios
- Gráficos
- Tema claro/escuro
- Exportação de dados

---

# 👨‍💻 Sobre mim

Meu nome é **João Victor Nery** e atualmente sou estudante de **Ciência da Computação na PUC Minas**.

Tenho interesse em desenvolvimento mobile e estou sempre buscando aprender novas tecnologias e construir projetos que me desafiem. Este projeto representa uma etapa importante da minha evolução com Flutter e Firebase e faz parte do meu portfólio como desenvolvedor.

Caso queira conversar ou dar algum feedback sobre o projeto, fique à vontade para entrar em contato.
