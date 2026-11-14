import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorPage(),
  );
}

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(a: a, b: b),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Осипов Роман'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
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
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.a, required this.b});
  final double a;
  final double b;

  @override
  Widget build(BuildContext context) {
    final result = (a + b) * (a + b);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результат'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          '($a + $b)² = $result',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
