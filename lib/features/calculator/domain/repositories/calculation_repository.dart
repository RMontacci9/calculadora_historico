import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';

abstract class CalculationRepository {
  Future<void> saveCalculation(Calculation calculation);
  Future<List<Calculation>>? getCalculations();
}