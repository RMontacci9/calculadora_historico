import 'dart:convert';

import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CalculationDataSource {
  Future<void> saveCalculation(Calculation calculation);
  Future<List<Calculation>> getCalculations();
}

class CalculationDataSourceImpl implements CalculationDataSource {
  static const String _calculationsKey = 'calculations_key';

  @override
  Future<void> saveCalculation(Calculation calculation) async {
    final prefs = await SharedPreferences.getInstance();
    final calculations = await getCalculations();
    calculations.add(calculation);

    final calculationsJson = calculations.map((calc) => jsonEncode({
      'operand1': calc.operand1,
      'operand2': calc.operand2,
      'operator': calc.operator,
      'result': calc.result,
    })).toList();

    await prefs.setStringList(_calculationsKey, calculationsJson);
  }

  @override
  Future<List<Calculation>> getCalculations() async {
    final prefs = await SharedPreferences.getInstance();
    final calculationsJson = prefs.getStringList(_calculationsKey) ?? [];

    return calculationsJson.map((calcJson) {
      final calcMap = jsonDecode(calcJson);
      return Calculation(
        operand1: calcMap['operand1'] ?? 0.0,
        operand2: calcMap['operand2'] ?? 0.0,
        operator: calcMap['operator'] ?? '',
        result: calcMap['result'] ?? 0.0,
      );
    }).toList();
  }
}
