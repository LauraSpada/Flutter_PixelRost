import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/models/game.dart';

class Gamecard extends StatelessWidget {
  final Game game;

  const Gamecard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
       margin: const EdgeInsets.all(12),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: game.image != null && game.image!.isNotEmpty
                ? Image.network(
                    game.image!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.gamepad, size: 60),
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            game.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            game.company,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
