import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/widgets/appMenuDrawer.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Appmenudrawer(),
      body: Center(
        child: Text(
          'Home Page!',
          style: GoogleFonts.pressStart2p(
            fontSize: 10,
          ),
          // textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
