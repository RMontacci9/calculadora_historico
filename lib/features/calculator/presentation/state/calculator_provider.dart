// lib/features/calculator/presentation/controllers/calculator_controller.dart
import 'package:app_calculadora_historico/features/calculator/domain/entities/calculation.dart';
import 'package:app_calculadora_historico/features/calculator/domain/repositories/calculation_repository.dart';
import 'package:app_calculadora_historico/features/calculator/domain/usecase/calculation_use_case.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  final CalculationRepository _repository;
  final CalculateUseCase _calculateUseCase;

  CalculatorProvider(this._repository, this._calculateUseCase) {
    _loadHistory();
  }

  String _displayText = '';
  List<Calculation> _history = [];

  String get displayText => _displayText;
  List<Calculation> get history => _history;

  Future<void> _loadHistory() async {
    try {
      final calculations = await _repository.getCalculations();
      _history = calculations ?? [];
    } catch (e) {
      _history = [];
    }
    notifyListeners();
  }


  void onNumberPressed(String number) {
    _displayText += number;
    notifyListeners();
  }

  void onOperatorPressed(String operator) {
    _displayText += ' $operator ';
    notifyListeners();
  }

  Future<void> onCalculatePressed() async {
    try {
      final parts = _displayText.split(' ');
      final operand1 = double.parse(parts[0]);
      final operator = parts[1];
      final operand2 = double.parse(parts[2]);

      final calculation = _calculateUseCase.execute(operand1, operand2, operator);

      await _repository.saveCalculation(calculation);
      _loadHistory();

      _displayText = calculation.result.toString();
      notifyListeners();
    } catch (e) {
      _displayText = 'Erro';
      notifyListeners();
    }
  }

  void onClearPressed() {
    _displayText = '';
    notifyListeners();
  }
}
