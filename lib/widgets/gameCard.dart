import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/models/game.dart';
import 'package:flutter_pixelroster/pages/gameUpdatePage.dart';
import 'package:flutter_pixelroster/services/game.dart';

class Gamecard extends StatelessWidget {
  final Game game;
  final GameService service;
  final VoidCallback onUpdated;

  const Gamecard({
    Key? key,
    required this.game,
    required this.service,
    required this.onUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final updatedGame = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameUpdatePage(service: service, game: game),
          ),
        );
        if (updatedGame != null) {
          onUpdated();
        }
      },
      child: Card(
        elevation: 6,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white, width: 3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1, // sempre quadrada
                child: game.image != null && game.image!.isNotEmpty
                    ? Image.network(game.image!, fit: BoxFit.cover)
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.gamepad, size: 60),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              game.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              game.company,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 8),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
