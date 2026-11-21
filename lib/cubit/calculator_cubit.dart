import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/calculation_storage.dart';
import 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit(this.storage) : super(const CalculatorState());
  final CalculationStorage storage;

  Future<void> calculate(double a, double b) async {
    emit(const CalculatorState(loading: true));
    final result = (a + b) * (a + b);
    try {
      await storage.save(a, b, result);
      if (!isClosed) emit(CalculatorState(a: a, b: b, result: result));
    } catch (_) {
      if (!isClosed) {
        emit(const CalculatorState(error: 'Не удалось сохранить расчёт'));
      }
    }
  }

  void reset() => emit(const CalculatorState());
}
