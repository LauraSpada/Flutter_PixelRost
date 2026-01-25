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
        color: isDarkMode ? Color(0xFF350D4C) : Color(0xFFAE86C1),
        child: Column(
          children: [
            const SizedBox(height: 2),
            Image.asset(
              isDark ? 'assets/logo-dark.png' : 'assets/logo-light.png',
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                "Home",
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
              leading: const Icon(Icons.star),
              title: Text(
                "Favorite Games",
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
              onTap: () => {Navigator.pushNamed(context, AppRoutes.gamelistfavorite)},
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: Text(
                "Developer",
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
              onTap: () => {Navigator.pushNamed(context, AppRoutes.about)},
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.extension),
              title: Text(
                "Settings",
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
              onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
