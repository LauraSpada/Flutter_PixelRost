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
    return Drawer(
      child: Container(
        color: isDarkMode ? Color(0xFF15047C) : Color(0xFFA77EF9),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.extension),
              title: Text(
                "Configurações",
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
              onTap: () => {Navigator.pushNamed(context, AppRoutes.settings)},
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
          ],
        ),
      ),
    );
  }
}
