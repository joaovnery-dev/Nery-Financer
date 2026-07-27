<div align="center">

<img src="./assets/logo.png" width="170">

# 💰 Nery Financer

Um aplicativo de controle financeiro desenvolvido com **Flutter** e **Firebase**.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Cloud_Firestore-FFCA28?logo=firebase)
![License](https://img.shields.io/badge/license-MIT-green)

</div>

---

# 📖 Sobre o projeto

O **Nery Financer** é um aplicativo de controle financeiro desenvolvido em Flutter com Firebase.

Criei esse projeto para colocar em prática tudo o que fui aprendendo durante meus estudos de Flutter. Mais do que fazer um aplicativo funcionar, meu objetivo foi entender como cada tecnologia se conecta dentro de uma aplicação real.

Cada usuário possui sua própria conta e pode cadastrar receitas e despesas, que ficam armazenadas no Cloud Firestore e são atualizadas automaticamente em tempo real.

---

# 🚀 Diferenciais

Durante o desenvolvimento deste projeto trabalhei com diversos conceitos importantes do desenvolvimento mobile:

- Login e cadastro utilizando Firebase Authentication;
- Banco de dados em tempo real com Cloud Firestore;
- CRUD completo de transações;
- Atualização automática da interface utilizando Stream e StreamBuilder;
- Conversão entre objetos Dart e documentos do Firestore utilizando `toMap()` e `fromMap()`;
- Organização do projeto em camadas;
- Widgets reutilizáveis;
- Programação Orientada a Objetos aplicada em um projeto real.

Cada funcionalidade foi implementada conforme eu aprendia novos conceitos durante os estudos. O objetivo não era apenas concluir o projeto, mas compreender como cada tecnologia funciona na prática.

---

# ✨ Funcionalidades

- ✅ Cadastro de usuários
- ✅ Login
- ✅ Logout
- ✅ Cadastro de receitas
- ✅ Cadastro de despesas
- ✅ Atualização automática das transações
- ✅ Organização das transações por usuário
- ✅ Categorias para cada movimentação
- ✅ Interface responsiva
- ✅ Widgets reutilizáveis

---

# 🛠 Tecnologias

| Tecnologia | Utilização |
|------------|------------|
| Flutter | Desenvolvimento da interface |
| Dart | Linguagem principal |
| Firebase Authentication | Autenticação |
| Cloud Firestore | Banco de dados |
| Material Design | Interface |

---

# 📂 Estrutura do projeto

```text
lib
│
├── camporReutilizaveis
│   ├── botao.dart
│   └── TextField.dart
│
├── codigosBase
│   ├── Categoria.dart
│   ├── Transacao.dart
│   └── tipoTransacao.dart
│
├── servicos
│   ├── authService.dart
│   └── firestore_service.dart
│
├── telas
│   ├── Home.dart
│   ├── tela_login.dart
│   ├── cadastro.dart
│   └── adicionar_transacao.dart
│
└── main.dart
```

---

# 🔥 Estrutura do banco de dados

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

Cada usuário possui sua própria coleção de transações, garantindo que seus dados permaneçam separados e seguros.

---

# 📸 Telas

| Login | Home |
|-------|------|
| <img src="./screens/login.png" width="260"> | <img src="./screens/home.png" width="260"> |

| Nova Transação |
|---------------|
| <img src="./screens/add.png" width="260"> |

> As imagens serão adicionadas em breve.

---

# 📖 O que aprendi

Durante o desenvolvimento deste projeto aprimorei conhecimentos em:

- Flutter
- Dart
- Programação Orientada a Objetos
- Firebase Authentication
- Cloud Firestore
- CRUD
- Stream
- StreamBuilder
- Organização de projetos
- Widgets reutilizáveis
- Navegação entre telas
- Conversão entre objetos e documentos do Firestore

---

# ▶ Como executar

Clone o projeto

```bash
git clone https://github.com/joaovnery-dev/Nery_Financer.git
```

Entre na pasta

```bash
cd Nery_Financer
```

Instale as dependências

```bash
flutter pub get
```

Execute o projeto

```bash
flutter run
```

---

# 📌 Próximas melhorias

- [ ] Editar transações
- [ ] Excluir transações deslizando o card
- [ ] Pesquisa por transações
- [ ] Filtro por categoria
- [ ] Relatórios financeiros
- [ ] Dashboard com gráficos
- [ ] Tema claro e escuro
- [ ] Exportação de dados
- [ ] Backup na nuvem

---

# 👨‍💻 Sobre mim

Meu nome é **João Victor Nery** e atualmente sou estudante de **Ciência da Computação na PUC Minas**.

Tenho interesse em desenvolvimento de software e estou sempre buscando aprender novas tecnologias através da criação de projetos práticos.

O **Nery Financer** representa uma etapa importante da minha evolução como desenvolvedor e faz parte do meu portfólio.

Se tiver alguma sugestão ou feedback, ficarei feliz em ouvir.

---

<div align="center">

⭐ Se este projeto foi interessante para você, considere deixar uma estrela no repositório!

</div>
