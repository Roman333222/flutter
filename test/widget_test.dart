import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';
import 'package:my_app/cubit/calculator_cubit.dart';

void main() {
  testWidgets('Проверка формы и расчёта', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Рассчитать'));
    await tester.pump();
    expect(find.text('Введите число'), findsNWidgets(2));
    expect(
      find.text('Необходимо согласие на обработку данных'),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextFormField).at(0), '2');
    await tester.enterText(find.byType(TextFormField).at(1), '3');
    await tester.tap(find.byType(CheckboxListTile));
    await tester.tap(find.text('Рассчитать'));
    await tester.pumpAndSettle();
    expect(find.text('(2.0 + 3.0)² = 25.0'), findsOneWidget);
    await tester.tap(find.text('Назад'));
    await tester.pumpAndSettle();
    expect(find.text('Рассчитать'), findsOneWidget);
  });

  test('Cubit вычисляет квадрат суммы и сбрасывает результат', () {
    final cubit = CalculatorCubit();
    cubit.calculate(-2, 5);
    expect(cubit.state.result, 9);
    cubit.reset();
    expect(cubit.state.result, isNull);
    cubit.close();
  });
}
