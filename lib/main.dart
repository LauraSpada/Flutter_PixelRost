import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/pages/aboutPage.dart';
import 'package:flutter_pixelroster/pages/gameCreatePage.dart';
import 'package:flutter_pixelroster/pages/gameListFavoritePage.dart';
import 'package:flutter_pixelroster/pages/gameListPage.dart';
import 'package:flutter_pixelroster/pages/homePage.dart';
import 'package:flutter_pixelroster/pages/loginPage.dart';
import 'package:flutter_pixelroster/pages/settingsPage.dart';
import 'package:flutter_pixelroster/pages/userFormPage.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/providers/user_provider.dart';
import 'package:flutter_pixelroster/routes.dart';
import 'package:flutter_pixelroster/services/game.dart';
import 'package:flutter_pixelroster/services/user.dart';
import 'package:provider/provider.dart';
import 'themes/app_themes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
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
      title: 'Flutter Pixel Roster',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: AppRoutes.login,
      routes: {
        '/login': (context) => Loginpage(userService: userService),
        '/home': (context) => const Homepage(),
        '/about': (context) => const Aboutpage(),
        '/userform': (context) => Userformpage(service: UserService()),
        '/gamelist': (context) => Gamelistpage(gameService: GameService()),
        '/gamelistfavorite': (context) => Gamelistfavoritepage(gameService: GameService()),
        '/gamecreate': (context) => Gamecreatepage(service: GameService()),
        '/settings': (context) => const Settingspage(),
      },
    );
  }
}
