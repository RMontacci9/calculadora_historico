
import 'package:flutter_test/flutter_test.dart';
import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';

void main() {
  group('Calculation', () {
    test('deve criar uma instância de Calculation corretamente', () {
      // Criando a instância da entidade Calculation
      final calculation = Calculation(
        operand1: 5.0,
        operand2: 3.0,
        operator: '+',
        result: 8.0,
      );

      // Verificando se os valores foram corretamente atribuídos
      expect(calculation.operand1, 5.0);
      expect(calculation.operand2, 3.0);
      expect(calculation.operator, '+');
      expect(calculation.result, 8.0);
    });
  });
}


