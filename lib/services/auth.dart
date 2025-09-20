import 'package:flutter_pixelroster/models/user.dart';
import 'user.dart';

class AuthService {
  final UserService _userService = UserService();

  Future<User?> login(String name, String password) async {
    try {
      List<User> users = await _userService.getUsers();

      User? user;
      try {
        user = users.firstWhere(
          (u) => u.name?.toLowerCase() == name.toLowerCase() &&
                 u.password == password,
        );
      } catch (e) {
        user = null;
      }

      return user;
    } catch (e) {
      print('Erro no login: $e');
      return null;
    }
  }
}
