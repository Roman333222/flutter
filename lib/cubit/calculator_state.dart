class CalculatorState {
  const CalculatorState({
    this.a,
    this.b,
    this.result,
    this.error,
    this.loading = false,
  });

  final double? a;
  final double? b;
  final double? result;
  final String? error;
  final bool loading;
}
