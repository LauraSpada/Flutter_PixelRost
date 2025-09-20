import 'package:flutter_pixelroster/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static const String baseurl =
      'https://68cc47cb716562cf50772028.mockapi.io/pixelroster';

  UserService();

  // Função privada para criar URLs com query params
  Uri _uri(String path, [Map<String, dynamic>? query]) => Uri.parse(
    '$baseurl$path',
  ).replace(queryParameters: query?.map((k, v) => MapEntry(k, v?.toString())));

  
  // Listar todos os usuários
  Future<List<User>> getUsers() async {
    final res = await http.get(_uri('/users'));
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      final List list = body is List ? body : (body['data'] ?? []);
      return list.map((e) => User.fromJson(e)).toList();
    }
    throw Exception('Falha ao carregar usuários (${res.statusCode})');
  }


  // Obter usuário por ID
  Future<User> getUser(String id) async {
    final res = await http.get(_uri('/users/$id'));
    if (res.statusCode == 200) {
      return User.fromJson(json.decode(res.body));
    }
    throw Exception('Falha ao carregar usuário (${res.statusCode})');
  }

  // Criar usuário
  Future<User> createUser(User user) async {
    final res = await http.post(
      _uri('/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      return User.fromJson(json.decode(res.body));
    }
    throw Exception('Falha ao criar usuário (${res.statusCode})');
  }

  /*
  // Atualizar usuário
  Future<User> updateUser(User user) async {
    if (user.id == null) throw Exception('Usuário sem ID');
    final res = await http.put(
      _uri('/users/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (res.statusCode == 200) {
      return User.fromJson(json.decode(res.body));
    }
    throw Exception('Falha ao atualizar usuário (${res.statusCode})');
  }

  // Deletar usuário
  Future<void> deleteUser(String id) async {
    final res = await http.delete(_uri('/users/$id'));
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Falha ao remover usuário (${res.statusCode})');
    }
  }
  */
  
}
