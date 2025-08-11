// lib/providers/search_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickmorty/models/character.dart';

class SearchProvider extends ChangeNotifier {
  List<Character> _allCharacters = [];
  List<Character> _filteredCharacters = [];
  bool _isLoading = false;

  List<Character> get characters => _filteredCharacters;
  bool get isLoading => _isLoading;

  // Buscar personagens da API
  Future<void> fetchCharacters() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List;

        _allCharacters = results.map((json) => Character.fromJson(json)).toList();
        _filteredCharacters = List.from(_allCharacters);
      }
    } catch (e) {
      // log de erro, se necessário
    }

    _isLoading = false;
    notifyListeners();
  }

  // Filtrar por nome
  void search(String query) {
    if (query.isEmpty) {
      _filteredCharacters = List.from(_allCharacters);
    } else {
      _filteredCharacters = _allCharacters
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
