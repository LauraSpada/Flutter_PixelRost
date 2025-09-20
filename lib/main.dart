import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/pages/aboutpage.dart';
import 'package:flutter_pixelroster/pages/homePage.dart';
import 'package:flutter_pixelroster/pages/loginPage.dart';
import 'package:flutter_pixelroster/pages/settingsPage.dart';
import 'package:flutter_pixelroster/pages/userFormPage.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/routes.dart';
import 'package:flutter_pixelroster/services/user.dart';
import 'package:provider/provider.dart';
import 'themes/app_themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userService = UserService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: AppRoutes.login,
      routes: {
         '/login': (context) => Loginpage(userService: userService),
        '/home': (context) => const Homepage(),
        '/settings': (context) => const Settingspage(),
        '/about': (context) => const Aboutpage(),
        '/userformpage': (context) => Userformpage(service: UserService()),
      },
    );
  }
}
