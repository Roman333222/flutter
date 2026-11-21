import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_app/cubit/cats_cubit.dart';
import 'package:my_app/cubit/cats_state.dart';
import 'package:my_app/requests/cats_api.dart';

void main() {
  test('Запрос читает фотографии и передаёт limit=10', () async {
    final client = MockClient((request) async {
      expect(request.url.queryParameters['limit'], '10');
      return http.Response(
        '[{"id":"cat1","url":"https://example.com/cat.jpg","width":400,"height":300}]',
        200,
      );
    });
    final api = CatsApi(client: client);
    final cats = await api.fetchCats();
    expect(cats.single.id, 'cat1');
    expect(cats.single.width, 400);
    api.dispose();
  });

  test('Cubit показывает ошибку при неуспешном ответе', () async {
    final client = MockClient((request) async => http.Response('error', 500));
    final cubit = CatsCubit(CatsApi(client: client));
    await cubit.load();
    expect(cubit.state, isA<CatsError>());
    await cubit.close();
  });
}
