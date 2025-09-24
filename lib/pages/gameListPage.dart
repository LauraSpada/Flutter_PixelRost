import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/models/game.dart';
import 'package:flutter_pixelroster/routes.dart';
import 'package:flutter_pixelroster/services/game.dart';
import 'package:flutter_pixelroster/widgets/appMenuDrawer.dart';
import 'package:flutter_pixelroster/widgets/gameCard.dart';
import 'package:google_fonts/google_fonts.dart';

class Gamelistpage extends StatefulWidget {
  final GameService gameService;

  const Gamelistpage({Key? key, required this.gameService}) : super(key: key);

  @override
  State<Gamelistpage> createState() => _GamelistpageState();
}

class _GamelistpageState extends State<Gamelistpage> {
  late Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = widget.gameService.getGames();
  }

  void reloadGames() {
    setState(() {
      futureGames = widget.gameService.getGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games", style: GoogleFonts.pressStart2p(fontSize: 15)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () => {
              Navigator.pushNamed(context, AppRoutes.gamecreate),
            },
          ),
        ],
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
                'Nenhum Jogo encontrado',
                style: GoogleFonts.pressStart2p(fontSize: 10),
              ),
            );
          }
          final games = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.80,
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
