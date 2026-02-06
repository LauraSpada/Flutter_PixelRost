# PixelRoster

- ### Objetivo:

O projeto foi desenvolvido com base na proposta da matéria de Desenvolvimento Mobile 3 que visou explorar as funcionalidades do Flutter.

O projeto ganhou o nome de 'PixelRoster', onde os usuários fazem o cadastro e têm acesso ao app para adicionar, atualizar e excluir os jogos listados por cards, os quais podem ser favoritados, também é possível mudar o tema do app para melhor experiência.

- ### Tecnologias Utilizadas:

| **Dart** -> linguagem de programação lançada pela Google em 2011 como alternativa para o desenvolvimento web. 

| **Flutter** -> framework de desenvolvimento de código aberto construído em Dart lançado também pela Google em 2018. Com o Flutter, é possível desenvolver aplicações mobile(android e ios), web e desktop, tudo a partir de uma única base de código, ou seja, o Flutter é multiplataforma 

```
Stateful -> Mutável (através de um objeto State), Gerencia estado interno com setState()
Stateless -> Imutável, Não gerencia estado
```

#

- ### Fluxo do Projeto:

-- cadastro usuário  
-- login  
-- crud jogos  
-- desenvolvedora (minhas informações)  
-- configurações (informações do usuário e tema claro/escuro)  

- ### Algumas Telas:

<img width="550" height="750" alt="DarkLightExamples" src="https://github.com/user-attachments/assets/7b9a03fe-f651-49fc-8794-05b683bc6e01" />

- ### Estrutura do Projeto:
```
assets/
lib/
|- models/
|	|- user
|	|- game
|- pages/ 
|	|- aboutPage
|	|- gameCreatePage
|	|- gameListFavoritePage
|	|- gameListPage
|	|- gameUpdatePage
|	|- homePage
|	|- loginPage
|	|- settingsPage
|	|- userFormPage
|- providers/
|	|- theme_provider
|	|- user_provider
|- services/
|	|- auth
|	|- game
|	|- user
|- themes/
|	|- app_themes
|- widgets/
|	|- appMenuDrawer
|	|-gameCard
|- main
|- routes
```

**lib**: repositório principal do código fonte  
**models**: classe de estrutura de dados  
**pages**: telas do app  
**providers**: gerenciador de estado  
**services**: lógica de negócios, nesse caso, a api  
**themes**: configurações visuais, nesse caso, lightTheme e darkTheme  
**widgets**: widgets customizados  
**assets**: imagens do projeto  
**pubspec.yalm**: dependências do projeto  

#

### Rodar o projeto:

- via web:
1) flutter/dart instalado
2) comandos: flutter run 
3) 2-Chrome
