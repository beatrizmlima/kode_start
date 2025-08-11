import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rickmorty/models/character.dart';
import 'package:rickmorty/theme/app_colors.dart';

class CharacterDetails extends StatelessWidget {
  final Character character;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final String? firstEpisodeName;

  const CharacterDetails({
    Key? key,
    required this.character,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.firstEpisodeName,
  }) : super(key: key);

  Widget statusDot(BuildContext context, String status, String species) {
    Color color;
    switch (status.toLowerCase()) {
      case 'alive':
        color = AppColors.statusAlive;
        break;
      case 'dead':
        color = AppColors.statusDead;
        break;
      default:
        color = AppColors.statusUnknown;
    }

    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          margin: const EdgeInsets.only(right: 8),
        ),
        Text(
          '$status - $species',
          style: GoogleFonts.lato(
            color: AppColors.textPrimary(context),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget infoBlock(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: GoogleFonts.lato(
            color: AppColors.textSecondary(context),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.lato(
            color: AppColors.textPrimary(context),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = character;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        // Imagem
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: CachedNetworkImage(
            imageUrl: c.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (_, __, ___) => const Icon(Icons.error),
          ),
        ),

        // Card com informações
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: Container(
            width: double.infinity,
            color: AppColors.cardBackground(context),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome + favorito
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        c.name.toUpperCase(),
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite
                            ? Colors.yellow[700]
                            : AppColors.textSecondary(context),
                      ),
                      onPressed: onToggleFavorite,
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Status
                statusDot(context, c.status, c.species),
                const SizedBox(height: 16),

                // Infos
                infoBlock(context, 'Gender', c.gender),
                infoBlock(context, 'Origin', c.origin),
                infoBlock(context, 'Last known location', c.location),
                infoBlock(context, 'First seen in',
                    firstEpisodeName ?? 'Loading...'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
