class Authentication {
  static final Map<String, String> _users = {
    'teste': 'teste',
  };

  static bool authenticate(String user, String password) {
    final pass = _users[user.trim()];
    return pass != null && pass == password;
  }

}