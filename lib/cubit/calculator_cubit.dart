import 'package:flutter_bloc/flutter_bloc.dart';

import 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(const CalculatorState());

  void calculate(double a, double b) {
    final result = (a + b) * (a + b);
    emit(CalculatorState(a: a, b: b, result: result));
  }

  void reset() => emit(const CalculatorState());
}
