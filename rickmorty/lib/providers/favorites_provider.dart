import 'package:flutter/material.dart';
import 'package:rickmorty/models/character.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Character> _favorites = [];

  List<Character> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Character character) {
    return _favorites.any((fav) => fav.id == character.id);
  }

  void toggleFavorite(Character character) {
    if (isFavorite(character)) {
      _favorites.removeWhere((fav) => fav.id == character.id);
    } else {
      _favorites.insert(0, character); // último favoritado aparece primeiro
    }
    notifyListeners();
  }
}
