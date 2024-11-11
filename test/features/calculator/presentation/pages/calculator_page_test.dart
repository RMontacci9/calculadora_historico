import 'package:app_calculadora_historico/features/calculator/domain/repositories/calculation_repository.dart';
import 'package:app_calculadora_historico/features/calculator/domain/usecase/calculation_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:app_calculadora_historico/features/calculator/presentation/pages/calculator_page.dart';
import 'package:app_calculadora_historico/features/calculator/presentation/state/calculator_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';

class MockCalculatorProvider extends Mock implements CalculatorProvider {}
class MockCalculationRepository extends Mock implements CalculationRepository {}
class MockCalculateUseCase extends Mock implements CalculateUseCase {}

void main() {
  group('CalculatorPage Widget Tests', () {
    late MockCalculatorProvider mockCalculatorProvider;
    late MockCalculationRepository mockCalculationRepository;
    late MockCalculateUseCase mockCalculateUseCase;

    setUp(() {
      mockCalculatorProvider = MockCalculatorProvider();
      mockCalculationRepository = MockCalculationRepository();
      mockCalculateUseCase = MockCalculateUseCase();

      when(() => mockCalculatorProvider.displayText).thenReturn('');
      when(() => mockCalculatorProvider.history).thenReturn([]);
    });

    testWidgets('deve exibir a interface corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<CalculatorProvider>(
            create: (context) => CalculatorProvider(mockCalculationRepository, mockCalculateUseCase),
            child: const CalculatorPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Calculadora'), findsOneWidget);
    });


    testWidgets('deve adicionar número ao displayText quando um número é pressionado', (WidgetTester tester) async {
      final mockCalculatorProvider = MockCalculatorProvider();

      when(() => mockCalculatorProvider.displayText).thenReturn('5');
      when(() => mockCalculatorProvider.history).thenReturn([]);  // Simular uma lista vazia para history
      when(() => mockCalculatorProvider.onNumberPressed(any())).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<CalculatorProvider>(
            create: (context) => mockCalculatorProvider,
            child: const CalculatorPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final numberButton = find.widgetWithText(ElevatedButton, '5');

      expect(numberButton, findsOneWidget);

      await tester.tap(numberButton);

      await tester.pumpAndSettle();

      verify(() => mockCalculatorProvider.onNumberPressed('5')).called(1);

      expect(mockCalculatorProvider.displayText, '5');
    });



    testWidgets('deve calcular o resultado e exibir no displayText', (WidgetTester tester) async {
      final mockCalculatorProvider = MockCalculatorProvider();
      final calculation = Calculation(
        operand1: 2.0,
        operand2: 3.0,
        operator: '+',
        result: 5.0,
      );

      // Configurações iniciais do mock
      when(() => mockCalculatorProvider.displayText).thenReturn('2 + 3');
      when(() => mockCalculatorProvider.history).thenReturn([calculation]);
      when(() => mockCalculatorProvider.onCalculatePressed()).thenAnswer((_) async {
        when(() => mockCalculatorProvider.displayText).thenReturn('5');
      });

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<CalculatorProvider>(
            create: (_) => mockCalculatorProvider,
            child: const CalculatorPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('='));
      await tester.pumpAndSettle(); // Espera a interface se atualizar

      expect(find.text('5'), findsOneWidget);

      // Verifica se o método `onCalculatePressed` foi chamado
      verify(() => mockCalculatorProvider.onCalculatePressed()).called(1);
    });




    testWidgets('deve exibir histórico de cálculos', (WidgetTester tester) async {
      final mockCalculatorProvider = MockCalculatorProvider();
      final calculation = Calculation(
        operand1: 2.0,
        operand2: 3.0,
        operator: '+',
        result: 5.0,
      );
      when(() => mockCalculatorProvider.history).thenReturn([calculation]);
      when(() => mockCalculatorProvider.displayText).thenReturn('');

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<CalculatorProvider>.value(
            value: mockCalculatorProvider,
            child: const CalculatorPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text('2.0 + 3.0 = 5.0'), findsOneWidget);
      // Verifica que o método para acessar o histórico foi chamado pelo menos 1 vez
      verify(() => mockCalculatorProvider.history).called(greaterThanOrEqualTo(1));
    });
  });
}
