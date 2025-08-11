import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rickmorty/theme/app_colors.dart';
import 'package:rickmorty/screens/favorites_screen.dart';

class DrawerComponent extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const DrawerComponent({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background(context),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 40),

          // --- Favoritos ---
          ListTile(
            leading: Icon(Icons.star, color: AppColors.textPrimary(context)),
            title: Text(
              "Favoritos",
              style: GoogleFonts.lato(
                color: AppColors.textPrimary(context),
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Fecha o drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoriteScreen(), // Seta na AppBar
                ),
              );
            },
          ),

          const Divider(),

          // --- Aparência ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              "Aparência",
              style: GoogleFonts.lato(
                color: AppColors.textPrimary(context),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SwitchListTile(
            title: Text(
              isDarkMode ? "Modo Escuro" : "Modo Claro",
              style: GoogleFonts.lato(
                color: AppColors.textPrimary(context),
                fontSize: 14,
              ),
            ),
            value: isDarkMode,
            onChanged: onThemeChanged,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
