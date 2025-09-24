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
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          height: MediaQuery.of(context).size.height * 0.70,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFFB5076B) : Color(0xFFFF7EC8),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             // const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/fotocaricatura.png'), //
              ),
              const SizedBox(height: 18),
              Divider(),
              const SizedBox(height: 18),
              Text("Laura Portela Spada"),
              const SizedBox(height: 18),
              Text("200921"),
              const SizedBox(height: 18),
              Text("Análise e Desenvolvimento de Sistemas"),
            //  const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
