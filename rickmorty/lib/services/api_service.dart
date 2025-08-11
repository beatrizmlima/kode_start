import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiService {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  static Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/character'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      return results.map((char) => Character.fromJson(char)).toList();
    } else {
      throw Exception('Erro ao carregar personagens');
    }
  }
}
