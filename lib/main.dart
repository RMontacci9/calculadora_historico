// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/injection.dart';
import 'features/calculator/presentation/pages/calculator_page.dart';
import 'features/calculator/presentation/state/calculator_provider.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<CalculatorProvider>(),  // Obtém o controller do GetIt
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculadora com Histórico',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const CalculatorPage(),
      ),
    );
  }
}
