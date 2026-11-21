class HistoryState {
  const HistoryState({this.loading = false, this.items = const [], this.error});

  final bool loading;
  final List<Map<String, Object?>> items;
  final String? error;
}
