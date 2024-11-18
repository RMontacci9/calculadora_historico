import 'package:app_calculadora_historico/features/calculator/data/datasources/calculation_local_datasource.dart';
import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late CalculationDataSourceImpl dataSourceImpl;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    dataSourceImpl = CalculationDataSourceImpl();
  });

  group('CalculationDatasSourceImpl', (){
    test('deve salvar e recuperar um cálculo', () async {
      final calculation = Calculation(
        operand1: 2,
        operand2: 3,
        operator: '+',
        result: 5,
      );

      await dataSourceImpl.saveCalculation(calculation);

      final calculations = await dataSourceImpl.getCalculations();
      expect(calculations.length, 1);
      expect(calculations.first.result, 5);
    });

    test('deve retornar uma lista vazia se não houver cálculos', () async {
      final calculations = await dataSourceImpl.getCalculations();
      expect(calculations, isEmpty);
    });
  });
}