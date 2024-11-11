import 'package:app_calculadora_historico/features/calculator/di/calculator_di.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  setupCalculatorInjection();
  // Futuras chamadas de setup para outras features podem ser adicionadas aqui, assim o codigo fica organizado e de facil modularização
}
