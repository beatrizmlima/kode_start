import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rickmorty/components/app_bar_component.dart';
import 'package:rickmorty/models/character.dart';
import 'package:rickmorty/providers/favorites_provider.dart';
import 'package:rickmorty/theme/app_colors.dart';
import 'package:rickmorty/widgets/character_details.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({Key? key, required this.character})
      : super(key: key);

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  String? firstEpisodeName;

  @override
  void initState() {
    super.initState();
    fetchFirstEpisodeName();
  }

  Future<void> fetchFirstEpisodeName() async {
    try {
      final response = await http.get(Uri.parse(widget.character.episode.first));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          firstEpisodeName = data['name'];
        });
      }
    } catch (e) {
      setState(() {
        firstEpisodeName = 'Desconhecido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.character;
    final favoritesProvider = context.watch<FavoritesProvider>();
    final isFavorite = favoritesProvider.isFavorite(c);

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: appBarComponent(context, isSecondPage: true),
      body: CharacterDetails(
        character: c,
        isFavorite: isFavorite,
        onToggleFavorite: () => favoritesProvider.toggleFavorite(c),
        firstEpisodeName: firstEpisodeName,
      ),
    );
  }
}
