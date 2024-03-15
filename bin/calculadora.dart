import 'package:calculadora/calculadora.dart' as calculadora;
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:math_expressions/math_expressions.dart';

void main() {
  Calculator cal = Calculator();
}

class Calculator {
  int size = 0;
  String equation = "";
  List<String> history = [];

  Calculator() {
    sayAlternatives();
  }

  void sayAlternatives() {
    print("Seja bem vindo a calculadora :)\nEscolha a alternativa");
    print(" 1 - soma \n 2 - Subtração \n 3 - multiplicação \n 4 - divisão \n 5 - historico");
    String? choice = stdin.readLineSync();

    try {
      var choiceNumber = int.parse(choice!);
      switch (choiceNumber) {
        case 1:
          print("Você escolheu soma.");
          sum();
          break;
        case 2:
          print("Você escolheu subtração.");
          sub();
          break;
        case 3:
          print("Você escolheu multiplicação.");
          mul();
          break;
        case 4:
          print("Você escolheu divisão.");
          div();
          break;
        case 5:
          showHistory();
          break;
        default:
          throw Exception("Opção invalida");
      }
    } catch (e) {
      invalidAlternatives();
    }
  }

  void invalidAlternatives() {
    print("\n\nValor digitado invalido!");
    sayAlternatives();
  }

  void sum() {
    print("Escolha o $size° valor");
    String? choice = stdin.readLineSync();

    try {
      int.parse(choice!);
      equation = "$equation$choice+";
      size++;

      addOrBreak("sum");
    } catch (err) {
      print("Opção invalida");
      sum();
    }
  }

  void sub() {
    print("Escolha o $size° valor");
    String? choice = stdin.readLineSync();

    try {
      int.parse(choice!);
      equation = "$equation$choice-";
      size++;

      addOrBreak("sub");
    } catch (err) {
      print("Opção invalida");
      sum();
    }
  }

  void mul() {
    print("Escolha o $size° valor");
    String? choice = stdin.readLineSync();

    try {
      int.parse(choice!);
      equation = "$equation$choice*";
      size++;

      addOrBreak("mul");
    } catch (err) {
      print("Opção invalida");
      sum();
    }
  }

  void div() {
    print("Escolha o $size° valor");
    String? choice = stdin.readLineSync();

    try {
      int.parse(choice!);
      equation = "$equation$choice/";
      size++;

      addOrBreak("div");
    } catch (err) {
      print("Opção invalida");
      sum();
    }
  }

  void addOrBreak(String operation) {
    print("Equação atual: $equation");
    print(
        "Escolha o proximo passo: \n1 - Adicionar mais\n2- Mudar operação\n3 - finalizar Operação\n4 - Voltar para o menu");
    String? choice = stdin.readLineSync();

    try {
      var choiceNumber = int.parse(choice!);
      switch (choiceNumber) {
        case 1:
          print("Você Adicionar mais.");
          switch (operation) {
            case "sum":
              sub();
              break;
            case "sub":
              sum();
              break;
            case "mul":
              sum();
              break;
            case "div":
              sum();
              break;
          }
          break;
        case 2:
          switchOperation();
          break;
        case 3:
          print("Você escolheu finalizar Operação.");
          calculateExpression();
          break;
        case 4:
          print("Você escolheu Voltar para o menu.");
          sayAlternatives();
          break;
        default:
          throw Exception("Opção invalida");
      }
    } catch (e) {
      print(e);
      print("Opção invalida");
      addOrBreak(operation);
    }
  }

  void showHistory() {
    print("\n\n");

    print("Historico: ");
    for (int i = 0; i < history.length; i++) {
      print(history[i]);
    }
    print("\n\n");

    sayAlternatives();
  }

  void switchOperation() {
    print("Escolha a operação que deseja\n 1 - soma \n 2 - Subtração \n 3 - multiplicação \n 4 - divisão");
    String? choice = stdin.readLineSync();

    try {
      var choiceNumber = int.parse(choice!);
      switch (choiceNumber) {
        case 1:
          print("Você escolheu soma.");
          sum();
          break;
        case 2:
          print("Você escolheu subtração.");
          sub();
          break;
        case 3:
          print("Você escolheu multiplicação.");
          mul();
          break;
        case 4:
          print("Você escolheu divisão.");
          div();
          break;
        default:
          throw Exception("Opção invalida");
      }
    } catch (e) {
      print("Valor invalido!");
      switchOperation();
    }
  }

  void calculateExpression() {
    if ("+-*/".contains(equation.substring(equation.length - 1))) {
      equation = equation.substring(0, equation.length - 1);
    }

    print(equation);

    Parser p = Parser();
    Expression exp = p.parse(equation);
    ContextModel cm = ContextModel();
    var result = exp.evaluate(EvaluationType.REAL, cm);
    DateTime now = DateTime.now();
    String date = DateFormat('dd/MM/yyyy HH:mm').format(now);
    result = "$equation = $result";
    String resultDate = "|$date| $result";
    history.add(resultDate);
    print(result);
    sayAlternatives();
  }
}
