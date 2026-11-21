import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/calculation_storage.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this.storage) : super(const HistoryState());
  final CalculationStorage storage;

  Future<void> load() async {
    emit(const HistoryState(loading: true));
    try {
      final items = await storage.loadHistory();
      if (!isClosed) emit(HistoryState(items: items));
    } catch (_) {
      if (!isClosed) {
        emit(const HistoryState(error: 'Не удалось загрузить историю'));
      }
    }
  }
}
