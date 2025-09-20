import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/widgets/appMenuDrawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configurações",
          style: GoogleFonts.pressStart2p(fontSize: 15),
        ),
      ),
      drawer: const Appmenudrawer(),
      body: Center(
        child: SwitchListTile(
          title: const Text("Modo Escuro"),
          value: isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme(value);
          },
        ),
      ),
    );
  }
}
