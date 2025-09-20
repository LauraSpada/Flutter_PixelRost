import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/pages/loginPage.dart';
import 'package:flutter_pixelroster/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class Userformpage extends StatefulWidget {
  const Userformpage({super.key});

  @override
  State<Userformpage> createState() => _UserformpageState();
}

class _UserformpageState extends State<Userformpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15047C),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginpage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEBE1FF),
                    ),
                    child: Text('Ir para Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
