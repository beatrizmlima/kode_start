import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rickmorty/components/app_bar_component.dart';
import 'package:rickmorty/components/drawer_component.dart';
import 'package:rickmorty/providers/favorites_provider.dart';
import 'package:rickmorty/providers/search_provider.dart';
import 'package:rickmorty/theme/app_colors.dart';
import 'package:rickmorty/widgets/character_card.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 20;
    const double verticalPadding = 20;

    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);

    final characters = searchProvider.characters;
    final isLoading = searchProvider.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: appBarComponent(context),
      drawer: DrawerComponent(
        isDarkMode: isDarkMode,
        onThemeChanged: onThemeChanged,
      ),
      body: Column(
        children: [
          // Campo de busca
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (query) => searchProvider.search(query),
              style: TextStyle(color: AppColors.textPrimary(context)),
              decoration: InputDecoration(
                hintText: 'Buscar personagem...',
                hintStyle: TextStyle(color: AppColors.textSecondary(context)),
                prefixIcon: Icon(Icons.search,
                    color: AppColors.textSecondary(context)),
                filled: true,
                fillColor: AppColors.cardBackground(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Lista / loading / vazio
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : (characters.isEmpty
                    ? Center(
                        child: Text(
                          "Nenhum personagem encontrado",
                          style: GoogleFonts.lato(
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        itemCount: characters.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: verticalPadding),
                        itemBuilder: (context, index) {
                          final c = characters[index];
                          return CharacterCard(
                            character: c,
                            isFavorite: favoritesProvider.isFavorite(c),
                            onToggleFavorite: () =>
                                favoritesProvider.toggleFavorite(c),
                          );
                        },
                      )),
          ),
        ],
      ),
    );
  }
}
