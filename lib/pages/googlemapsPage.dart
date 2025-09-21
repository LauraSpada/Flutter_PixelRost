import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Googlemapspage extends StatefulWidget {
  const Googlemapspage({super.key});

  @override
  State<Googlemapspage> createState() => _GooglemapspageState();
}

class _GooglemapspageState extends State<Googlemapspage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return const Scaffold();
  }
}