import 'package:app_calculadora_historico/features/calculator/data/repositories/calculation_repository_impl.dart';
import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';
import 'package:app_calculadora_historico/features/calculator/domain/usecase/calculation_use_case.dart';
import 'package:app_calculadora_historico/features/calculator/presentation/state/calculator_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockCalculationRepository extends Mock implements CalculationRepositoryImpl {}
class MockCalculateUseCase extends Mock implements CalculateUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockCalculationRepository mockRepository;
  late MockCalculateUseCase mockUseCase;
  late CalculatorProvider calculatorProvider;

  setUp(() async {

    SharedPreferences.setMockInitialValues({});
    mockRepository = MockCalculationRepository();
    mockUseCase = MockCalculateUseCase();
    when(mockRepository.getCalculations()).thenAnswer((_) async => <Calculation>[]);
    calculatorProvider = CalculatorProvider(mockRepository, mockUseCase);
  });

  test('onNumberPressed adiciona número ao displayText', () {
    calculatorProvider.onNumberPressed('5');

    expect(calculatorProvider.displayText, '5');
  });

  test('onOperatorPressed adiciona operador ao displayText', () {
    // Simula pressionar números e operador
    calculatorProvider.onNumberPressed('2');
    calculatorProvider.onOperatorPressed('+');
    calculatorProvider.onNumberPressed('3');

    expect(calculatorProvider.displayText, '2 + 3');
  });


  test('onClearPressed limpa o displayText', () {
    calculatorProvider.onNumberPressed('5');
    calculatorProvider.onNumberPressed('5');
    expect(calculatorProvider.displayText, '55');
    calculatorProvider.onClearPressed();
    expect(calculatorProvider.displayText, '');
  });
}
