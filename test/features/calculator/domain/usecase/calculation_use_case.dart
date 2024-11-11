import 'package:app_calculadora_historico/features/calculator/domain/usecase/calculation_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final useCase = CalculateUseCaseImpl();

  group('CalculationUseCase', (){
    test('deve retornar a soma de dois números', () {
      final result = useCase.execute(3, 2, '+');
      expect(result.result, 5);
    });

    test('deve retornar a subtração de dois números', () {
      final result = useCase.execute(5, 3, '-');
      expect(result.result, 2);
    });

    test('deve retornar a multiplicação de dois números', () {
      final result = useCase.execute(4, 3, '*');
      expect(result.result, 12);
    });

    test('deve retornar a divisão de dois números', () {
      final result = useCase.execute(6, 2, '/');
      expect(result.result, 3);
    });

    test('deve retornar NaN ao dividir por zero', () {
      final result = useCase.execute(6, 0, '/');
      expect(result.result.isNaN, true);
    });

    test('deve lançar erro para operador inválido', () {
      expect(() => useCase.execute(6, 2, '%'), throwsArgumentError);
    });
  });

}