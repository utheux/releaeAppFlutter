# Relêaê

Relêaê é um aplicativo Flutter voltado para criação, organização e revisão de cards de estudo. A proposta do app é ajudar o usuário a registrar conteúdos importantes, acompanhar cards pendentes de revisão e manter uma rotina de aprendizado mais simples.

## Funcionalidades

- Cadastro de usuário com nome, sobrenome, username, e-mail e senha.
- Login de usuário com persistência de sessão por cookies.
- Criação de cards com título e descrição.
- Listagem de todos os cards cadastrados.
- Exclusão de cards.
- Tela de cards para revisão, carregando os itens retornados por `findReviewCards()`.
- Abertura de card em modal para leitura durante a revisão.
- Registro automático da revisão do card usando `reviewCard()`.
- Favoritar e remover cards dos favoritos.
- Armazenamento local dos favoritos com SQLite.
- Listagem de cards favoritos.
- Tela de notícias carregadas da API pelo endpoint `/redditPosts`.
- Navegação por barra inferior com atalhos para notícias, cards, favoritos e revisões.

## Tecnologias utilizadas

- Flutter para desenvolvimento da interface mobile.
- Dart como linguagem principal.
- Dio para comunicação HTTP com a API.
- Cookie Jar e Dio Cookie Manager para gerenciamento de cookies e sessão.
- SQLite com `sqflite` para armazenamento local dos favoritos.
- `path` para suporte aos caminhos do banco local.
- Google Fonts para tipografia.
- Material Design para componentes visuais.
- API backend configurada em `lib/core/apiClient.dart`, atualmente apontando para `http://10.0.2.2:3333`.

## Pré-requisitos

- Flutter SDK instalado e configurado.
- Dart SDK compatível com o projeto. O `pubspec.yaml` usa SDK `^3.10.7`.
- Android Studio, VS Code ou outro editor com suporte a Flutter.
- Emulador Android, dispositivo físico ou outro alvo Flutter configurado.
- Backend da aplicação rodando e acessível pelo app.
- Para uso no emulador Android, o backend local deve estar disponível em `http://10.0.2.2:3333`.
- O endereço `10.0.2.2` representa o `localhost` do computador quando o app roda no emulador Android padrão do Android Studio. Se estiver usando Genymotion, geralmente o endereço equivalente é `10.0.3.2`. Em um celular físico, use o IP do computador na mesma rede, por exemplo `http://192.168.0.10:3333`.
- Dependências do projeto instaladas com:

```bash
flutter pub get
```

Para executar o app:

```bash
flutter run
```
