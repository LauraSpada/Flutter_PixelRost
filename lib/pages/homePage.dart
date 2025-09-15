import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/widgets/appMenuDrawer.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBE1FF),
      appBar: AppBar(),
      drawer: const Appmenudrawer(),
      body: Center(
        child: Text(
          'Página Home!',
          style: GoogleFonts.pressStart2p(
            fontSize: 20,
            color: Color(0xFFA9A9A9),
          ),
          // textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
