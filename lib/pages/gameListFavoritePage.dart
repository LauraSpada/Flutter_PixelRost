import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/models/game.dart';
import 'package:flutter_pixelroster/routes.dart';
import 'package:flutter_pixelroster/services/game.dart';
import 'package:flutter_pixelroster/widgets/appMenuDrawer.dart';
import 'package:flutter_pixelroster/widgets/gameCard.dart';
import 'package:google_fonts/google_fonts.dart';

class Gamelistfavoritepage extends StatefulWidget {
  final GameService gameService;

  const Gamelistfavoritepage({Key? key, required this.gameService}) : super(key: key);

  @override
  State<Gamelistfavoritepage> createState() => _GamelistfavoritepageState();
}

class _GamelistfavoritepageState extends State<Gamelistfavoritepage> {
  late Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = widget.gameService.getFavoriteGames();
  }

  void reloadGames() {
    setState(() {
      futureGames = widget.gameService.getFavoriteGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Games", style: GoogleFonts.pressStart2p(fontSize: 15)),
      ),
      drawer: const Appmenudrawer(),
      body: FutureBuilder<List<Game>>(
        future: futureGames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Favorite Games',
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
            );
          }
          final games = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.60,
            ),
            itemCount: games.length,
            itemBuilder: (context, index) {
              return Gamecard(
                game: games[index],
                service: widget.gameService,
                onUpdated: reloadGames,
              );
            },
          );
        },
      ),
    );
  }
}
