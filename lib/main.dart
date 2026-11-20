import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/calculator_cubit.dart';
import 'screens/calculator_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => CalculatorCubit(),
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    ),
  );
}
