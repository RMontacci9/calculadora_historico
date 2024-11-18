import 'package:app_calculadora_historico/features/calculator/data/datasources/calculation_local_datasource.dart';
import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';
import 'package:app_calculadora_historico/features/calculator/domain/repositories/calculation_repository.dart';

class CalculationRepositoryImpl implements CalculationRepository {
  final CalculationDataSource dataSource;

  CalculationRepositoryImpl(this.dataSource);
  @override
  Future<void> saveCalculation(Calculation calculation) async {
    try {
      await dataSource.saveCalculation(calculation);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Calculation>> getCalculations() async {
    try {
      return await dataSource.getCalculations();
    } catch (e) {
      return [];
    }
  }
}
