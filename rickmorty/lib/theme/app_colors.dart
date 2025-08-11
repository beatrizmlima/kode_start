import 'package:flutter/material.dart';

class AppColors {
  // Azul claro que já estava
  static const Color primaryColorLight = Color(0xFF87A1FA);

  // AppBar escura
  static const Color appBarColorDark = Color(0xFF1C1B1F);
  static const Color appBarColorLight = Color(0xB3FFFFFF);

  // Fundo
  static const Color backgroundDark = Color(0xFF000000);
  static const Color backgroundLight = Colors.white;

  // Branco e preto fixos
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Fundo dos cards
  static const Color cardBackgroundDark = Color(0xFF87A1FA);
  static const Color cardBackgroundLight = Color(0xFF73D6F7);

  // Texto secundário
  static const Color textSecondaryDark = Color(0xB3FFFFFF);
  static const Color textSecondaryLight = Colors.black54;

  // Status
  static const Color statusAlive = Color(0xFF55CB44);
  static const Color statusDead = Color(0xFFD53C2E);
  static const Color statusUnknown = Color(0xFF9E9E9E);

  // Métodos dinâmicos ------------------------------

  static Color appBarColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? appBarColorDark
          : appBarColorLight;

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? backgroundDark
          : backgroundLight;

  static Color cardBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? cardBackgroundDark
          : cardBackgroundLight;

  static Color textPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? white
          : black;

  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? textSecondaryDark
          : textSecondaryLight;
}
