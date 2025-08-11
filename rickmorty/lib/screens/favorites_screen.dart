import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rickmorty/components/app_bar_component.dart';
import 'package:rickmorty/providers/favorites_provider.dart';
import 'package:rickmorty/screens/character_detail_screen.dart';
import 'package:rickmorty/theme/app_colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;

    const double horizontalPadding = 20;
    const double verticalPadding = 20;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: appBarComponent(
        context,
        isSecondPage: true,
        title: 'FAVORITOS',
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                "Nenhum favorito ainda.",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: AppColors.textPrimary(context),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: ListView.separated(
                itemCount: favorites.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: verticalPadding),
                itemBuilder: (context, index) {
                  final c = favorites[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CharacterDetailScreen(character: c),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Imagem
                          CachedNetworkImage(
                            imageUrl: c.image,
                            height: 150,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (_, __, ___) => const Icon(Icons.error),
                          ),

                          // Bloco com nome + ícone de favorito
                          Container(
                            color: AppColors.cardBackground(context),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    c.name.toUpperCase(),
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary(context),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  onPressed: () {
                                    favoritesProvider.toggleFavorite(c);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
