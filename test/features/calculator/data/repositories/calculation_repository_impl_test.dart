import 'package:app_calculadora_historico/features/calculator/data/datasources/calculation_local_datasource.dart';
import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';
import 'package:app_calculadora_historico/features/calculator/data/repositories/calculation_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCalculationDataSource extends Mock implements CalculationDataSource {}

void main() {
  late MockCalculationDataSource mockDataSource;
  late CalculationRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCalculationDataSource();
    repository = CalculationRepositoryImpl(mockDataSource);
  });

  test('deve delegar saveCalculation para o dataSource', () async {
    final calculation = Calculation(operand1: 2.0, operand2: 3.0, operator: '+', result: 5.0);

    when(() => mockDataSource.saveCalculation(calculation)).thenAnswer((_) async {});

    await repository.saveCalculation(calculation);

    verify(() => mockDataSource.saveCalculation(calculation)).called(1);
  });

  test('deve delegar getCalculations para o dataSource', () async {
    final calculations = [
      Calculation(operand1: 2.0, operand2: 3.0, operator: '+', result: 5.0),
    ];

    when(() => mockDataSource.getCalculations()).thenAnswer((_) async => calculations);

    final result = await repository.getCalculations();

    expect(result, calculations);
    verify(() => mockDataSource.getCalculations()).called(1);
  });
}
