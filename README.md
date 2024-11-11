# Calculadora com Histórico

Este repositório contém uma aplicação Flutter de calculadora que permite realizar operações matemáticas básicas e manter um histórico das operações realizadas. O projeto foi desenvolvido com boas práticas de arquitetura e testes automatizados para demonstrar conhecimentos aplicáveis ao dia a dia de desenvolvimento.

## Estrutura do Projeto

A aplicação segue o modelo de **Clean Architecture**, com as seguintes camadas principais:

- **core:** Contém configurações globais e utilitários compartilhados.
- **domain:** Define entidades e casos de uso.
- **features:** Contém as funcionalidades específicas do projeto, como a calculadora.

### Tecnologias Utilizadas

- **Flutter:** Framework para desenvolvimento multiplataforma.
- **Provider:** Para gerenciamento de estado.
- **GetIt:** Para injeção de dependências.
- **Mocktail:** Para criação de mocks durante os testes.
- **Testes Automatizados:** Testes unitários e de widget foram implementados.

## Funcionalidades

- Realizar operações matemáticas básicas (soma, subtração, multiplicação, divisão).
- Exibir o histórico das operações realizadas.
- Limpeza do display.
- Arquitetura modular e testável.

## Como Executar

1. Clone o repositório:
 ```bash
   git clone https://github.com/seu-usuario/calculadora_historico.git
```
```bash
   cd calculadora_historico
```
2. Instale as dependências:
```bash
     flutter pub get
```
4. Execute a aplicação:
```bash
     flutter run
```
## Como Executar os Testes
Para rodar os testes automatizados:
```bash
 flutter test
```
## O que Pode Ser Melhorado
- Implementar a funcionalidade de limpeza do histórico.
- Adicionar mais testes para aumentar a cobertura de código.
- Refinar o design e melhorar a experiência do usuário.

## Contato
Se precisar de mais informações ou quiser discutir melhorias no projeto, fique à vontade para entrar em contato!
