// lib/features/calculator/presentation/pages/calculator_page.dart
import 'package:app_calculadora_historico/features/calculator/presentation/state/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: Text(controller.displayText, style: const TextStyle(fontSize: 32)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7', controller.onNumberPressed),
              _buildButton('8', controller.onNumberPressed),
              _buildButton('9', controller.onNumberPressed),
              _buildButton('+', controller.onOperatorPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4', controller.onNumberPressed),
              _buildButton('5', controller.onNumberPressed),
              _buildButton('6', controller.onNumberPressed),
              _buildButton('-', controller.onOperatorPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1', controller.onNumberPressed),
              _buildButton('2', controller.onNumberPressed),
              _buildButton('3', controller.onNumberPressed),
              _buildButton('*', controller.onOperatorPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('0', controller.onNumberPressed),
              _buildButton('C', (_) => controller.onClearPressed()),
              _buildButton('=', (_) => controller.onCalculatePressed()),
              _buildButton('/', controller.onOperatorPressed),
            ],
          ),
          const Divider(),
          Expanded(
            child: _buildHistoryList(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, void Function(String) onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(label),
      child: Text(label, style: const TextStyle(fontSize: 24)),
    );
  }

  Widget _buildHistoryList(CalculatorProvider controller) {
    return ListView.builder(
      itemCount: controller.history.length,
      itemBuilder: (context, index) {
        final calculation = controller.history[index];
        return ListTile(
          title: Text('${calculation.operand1} ${calculation.operator} ${calculation.operand2} = ${calculation.result}'),
          leading: const Icon(Icons.history),
        );
      },
    );
  }
}
