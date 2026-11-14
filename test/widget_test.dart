import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';

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
  });
}
