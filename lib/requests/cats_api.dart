import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cat_image.dart';

class CatsApi {
  CatsApi({http.Client? client}) : client = client ?? http.Client();
  final http.Client client;

  Future<List<CatImage>> fetchCats() async {
    final uri = Uri.https('api.thecatapi.com', '/v1/images/search', {
      'limit': '10',
      'mime_types': 'jpg,png',
    });
    final response = await client.get(uri).timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) {
      throw Exception('Ошибка сервера: ${response.statusCode}');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => CatImage.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  void dispose() => client.close();
}
