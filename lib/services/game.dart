import 'package:flutter_pixelroster/models/game.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GameService {
  static const String baseurl =
      'https://68cc47cb716562cf50772028.mockapi.io/pixelroster';

  GameService();

  Uri _uri(String path, [Map<String, dynamic>? query]) => Uri.parse(
    '$baseurl$path',
  ).replace(queryParameters: query?.map((k, v) => MapEntry(k, v?.toString())));

  Future<List<Game>> getGames() async {
    final res = await http.get(_uri('/games'));
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      final List list = body is List ? body : (body['data'] ?? []);
      return list.map((e) => Game.fromJson(e)).toList();
    }
    throw Exception('Falha ao carregar os Jogos (${res.statusCode})');
  }

  Future<List<Game>> getFavoriteGames() async {
    final games = await getGames();
    return games.where((game) => game.favorite).toList();
  }

  Future<Game> getGame(String id) async {
    final res = await http.get(_uri('/games/$id'));
    if (res.statusCode == 200) {
      return Game.fromJson(json.decode(res.body));
    }
    throw Exception('Falha ao carregar o Jogo (${res.statusCode})');
  }

  Future<Game> createGame(Game game) async {
    final res = await http.post(
      _uri('/games'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(game.toJson()),
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      return Game.fromJson(json.decode(res.body));
    }
    throw Exception('Falha ao criar Jogo (${res.statusCode})');
  }

  Future<Game> updateGame(Game game) async {
    if (game.id == null) throw Exception('Jogo sem ID');
    final res = await http.put(
      _uri('/games/${game.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(game.toJson()),
    );
    if (res.statusCode == 200) {
      return Game.fromJson(json.decode(res.body));
    }
    throw Exception('Falha ao atualizar Jogo (${res.statusCode})');
  }

  Future<void> deleteGame(String id) async {
    final res = await http.delete(_uri('/games/$id'));
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Falha ao remover Jogo (${res.statusCode})');
    }
  }
}
