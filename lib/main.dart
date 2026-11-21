import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/calculator_cubit.dart';
import 'data/calculation_storage.dart';
import 'screens/calculator_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.storage});
  final CalculationStorage? storage;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => CalculatorCubit(storage ?? CalculationStorage()),
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    ),
  );
}
