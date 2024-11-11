import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';

abstract class CalculateUseCase {
  Calculation execute(double operand1, double operand2, String operator);
}

class CalculateUseCaseImpl implements CalculateUseCase {
  @override
  Calculation execute(double operand1, double operand2, String operator) {
    double result;

    switch (operator) {
      case '+':
        result = operand1 + operand2;
        break;
      case '-':
        result = operand1 - operand2;
        break;
      case '*':
        result = operand1 * operand2;
        break;
      case '/':
        result = operand2 != 0 ? operand1 / operand2 : double.nan;
        break;
      default:
        throw ArgumentError('Operador inválido');
    }

    return Calculation(
      operand1: operand1,
      operand2: operand2,
      operator: operator,
      result: result,
    );
  }
}
