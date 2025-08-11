import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rickmorty/theme/app_colors.dart';
import 'package:rickmorty/theme/app_images.dart';

PreferredSizeWidget appBarComponent(
  BuildContext context, {
  bool isSecondPage = false,
  String? title,
}) {
  const double topIconPadding = 10.0;
  final textColor = AppColors.textPrimary(context);

  return AppBar(
    backgroundColor: AppColors.appBarColor(context),
    elevation: 0,
    centerTitle: true,
    toolbarHeight: 100,
    automaticallyImplyLeading: false,

    // usa Builder para obter um contexto que esteja abaixo do Scaffold
    leading: Builder(builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.only(top: topIconPadding, left: 12),
        child: IconButton(
          icon: Icon(isSecondPage ? Icons.arrow_back : Icons.menu, color: textColor),
          onPressed: () {
            if (isSecondPage) {
              // tenta dar pop com o contexto externo (mais confiável)
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                // fallback (não vai lançar se não houver o que popar)
                Navigator.maybePop(ctx);
              }
            } else {
              // tenta abrir o drawer de forma segura (se houver)
              final scaffoldState = Scaffold.maybeOf(ctx);
              if (scaffoldState != null) {
                try {
                  scaffoldState.openDrawer();
                } catch (_) {
                  // se não tiver drawer, ignora silenciosamente
                }
              }
            }
          },
        ),
      );
    }),

    // ícone de perfil à direita
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: topIconPadding, right: 12),
        child: Icon(
          Icons.account_circle_outlined,
          color: textColor,
          size: 32,
        ),
      ),
    ],

    // título: se passado, mostra só o texto; caso contrário, mostra logo + texto padrão
    title: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // sempre tenta mostrar a logo (se não existir o asset, trate no pubspec)
        Image.asset(
          AppImages.logo,
          height: 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 6),
        Text(
          title ?? 'RICK AND MORTY API',
          style: GoogleFonts.lato(
            color: textColor,
            fontSize: title != null ? 16 : 14.5,
            fontWeight: title != null ? FontWeight.w600 : FontWeight.w400,
            letterSpacing: title != null ? 0 : 2.4,
          ),
        ),
      ],
    ),
  );
}