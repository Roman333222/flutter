import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/calculator_cubit.dart';
import '../cubit/calculator_state.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final formKey = GlobalKey<FormState>();
  final aController = TextEditingController();
  final bController = TextEditingController();
  bool agreed = false;
  bool showConsentError = false;

  @override
  void dispose() {
    aController.dispose();
    bController.dispose();
    super.dispose();
  }

  String? validateNumber(String? value) {
    final number = double.tryParse((value ?? '').replaceAll(',', '.'));
    if (number == null || !number.isFinite) return 'Введите число';
    return null;
  }

  void calculate() {
    final valid = formKey.currentState!.validate();
    setState(() => showConsentError = !agreed);
    if (!valid || !agreed) return;
    final a = double.parse(aController.text.replaceAll(',', '.'));
    final b = double.parse(bController.text.replaceAll(',', '.'));
    context.read<CalculatorCubit>().calculate(a, b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Осипов Роман'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<CalculatorCubit, CalculatorState>(
        builder: (context, state) {
          if (state.result != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '(${state.a} + ${state.b})² = ${state.result}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<CalculatorCubit>().reset(),
                    child: const Text('Назад'),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Калькулятор квадрата суммы (a + b)²',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    controller: aController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: const InputDecoration(labelText: 'Число a'),
                    validator: validateNumber,
                  ),
                  TextFormField(
                    controller: bController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: const InputDecoration(labelText: 'Число b'),
                    validator: validateNumber,
                  ),
                  CheckboxListTile(
                    title: const Text('Согласен на обработку данных'),
                    value: agreed,
                    onChanged: (value) => setState(() {
                      agreed = value ?? false;
                      showConsentError = false;
                    }),
                  ),
                  if (showConsentError)
                    const Text(
                      'Необходимо согласие на обработку данных',
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: calculate,
                    child: const Text('Рассчитать'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
