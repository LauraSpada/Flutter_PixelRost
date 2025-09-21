import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Appmenudrawer extends StatelessWidget {
  const Appmenudrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      child: Container(
        color: isDarkMode ? Color(0xFF45046A) : Color(0xFF671993),
        child: Column(
          children: [
            Image.asset(
              isDark ? 'assets/logo-dark.png' : 'assets/logo-light.png',
            ),
            const SizedBox(height: 4),
            Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                "Início",
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
              onTap: () => {Navigator.pushNamed(context, AppRoutes.home)},
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.gamepad),
              title: Text(
                "Games",
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
              onTap: () => {Navigator.pushNamed(context, AppRoutes.gamelist)},
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: Text(
                "Sobre",
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
              onTap: () => {Navigator.pushNamed(context, AppRoutes.about)},
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.extension),
              title: Text(
                "Configurações",
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
              onTap: () => {Navigator.pushNamed(context, AppRoutes.settings)},
            ),
          ],
        ),
      ),
    );
  }
}
