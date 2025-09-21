import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/widgets/appMenuDrawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre", style: GoogleFonts.pressStart2p(fontSize: 15)),
      ),
      drawer: const Appmenudrawer(),
      body: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/fotocaricatura.png'), //
          ),
          const SizedBox(height: 20),
          Divider(),
          const SizedBox(height: 20),
          Text("Laura Portela Spada"),
          const SizedBox(height: 20),
          Text("200921"),
          const SizedBox(height: 20),
          Text("Análise e Desenvolvimento de Sistemas"),
          //Text(""),
        ],
      ),
    );
  }
}
