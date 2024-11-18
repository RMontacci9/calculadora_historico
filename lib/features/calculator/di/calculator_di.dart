import 'package:app_calculadora_historico/features/calculator/data/datasources/calculation_local_datasource.dart';
import 'package:app_calculadora_historico/features/calculator/data/repositories/calculation_repository_impl.dart';
import 'package:app_calculadora_historico/features/calculator/domain/repositories/calculation_repository.dart';
import 'package:app_calculadora_historico/features/calculator/domain/usecase/calculation_use_case.dart';
import 'package:get_it/get_it.dart';

import '../presentation/state/calculator_provider.dart';

final getIt = GetIt.instance;

void setupCalculatorInjection() {
  getIt.registerLazySingleton<CalculationDataSource>(() => CalculationDataSourceImpl());
  getIt.registerLazySingleton<CalculationRepository>(() => CalculationRepositoryImpl(getIt<CalculationDataSource>()));
  getIt.registerLazySingleton<CalculationRepositoryImpl>(() => CalculationRepositoryImpl(getIt<CalculationDataSource>()));
  getIt.registerLazySingleton<CalculateUseCase>(() => CalculateUseCaseImpl());
  getIt.registerFactory(() => CalculatorProvider(getIt<CalculationRepository>(), getIt<CalculateUseCase>()));
}