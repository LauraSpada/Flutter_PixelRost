import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/pages/homePage.dart';
import 'package:flutter_pixelroster/pages/loginPage.dart';
import 'package:flutter_pixelroster/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //initialRoute: '/login',
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const Loginpage(),
        //'/login': (context) => const Loginpage(),
        AppRoutes.home: (_) => const Homepage(),
        //'/home': (context) => const Homepage(),
        //AppRoutes.user: (_) => Userlistpage(userService: userservice),
      },
    );
  }
}
