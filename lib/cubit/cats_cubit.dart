import 'package:flutter_bloc/flutter_bloc.dart';

import '../requests/cats_api.dart';
import 'cats_state.dart';

class CatsCubit extends Cubit<CatsState> {
  CatsCubit(this.api) : super(CatsLoading());
  final CatsApi api;

  Future<void> load() async {
    emit(CatsLoading());
    try {
      final cats = await api.fetchCats();
      if (cats.isEmpty) throw Exception('Пустой ответ');
      if (!isClosed) emit(CatsLoaded(cats));
    } catch (_) {
      if (!isClosed) emit(CatsError());
    }
  }

  @override
  Future<void> close() {
    api.dispose();
    return super.close();
  }
}
