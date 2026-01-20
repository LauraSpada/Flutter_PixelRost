import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/providers/user_provider.dart';
import 'package:flutter_pixelroster/services/auth.dart';
import 'package:flutter_pixelroster/services/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  final UserService userService;

  const Loginpage({Key? key, required this.userService}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formkey = GlobalKey<FormState>();
  final _usrController = TextEditingController();
  final _pwdController = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  final AuthService _authService = AuthService();

  void _doLogin() async {
    if (!_formkey.currentState!.validate()) return;

    setState(() => _loading = true);

    final user = await _authService.login(
      _usrController.text.trim(),
      _pwdController.text,
    );

    if (user != null && mounted) {
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      Navigator.pushReplacementNamed(context, '/home');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário ou senha incorretos')),
      );
    }

    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF350D4C) : Color(0xFFAE86C1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  Image.asset(
                    isDark ? 'assets/logo-dark.png' : 'assets/logo-light.png',
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        // const SizedBox(height: 12),
                        TextFormField(
                          controller: _usrController,
                          decoration: InputDecoration(
                            labelText: 'Usuário',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: const Color(0xFFEBE1FF),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _pwdController,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: const Color(0xFFEBE1FF),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          obscureText: _obscure,
                          onFieldSubmitted: (_) => _doLogin(),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Informe a senha';
                            }
                            if (v.length < 3) {
                              return 'A senha deve ter ao menos 3 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _doLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEBE1FF),
                          ),
                          child: Text(
                            'Entrar',
                            style: GoogleFonts.pressStart2p(fontSize: 10,
                            color: isDarkMode
                                ? Color(0xFFB5076B)
                                : Color(0xFFD66AC2),),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Divider(),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/userform');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEBE1FF),
                          ),
                          child: Text(
                            'Fazer Cadastro',
                            style: GoogleFonts.pressStart2p(fontSize: 10,
                            color: isDarkMode
                                ? Color(0xFFB5076B)
                                : Color(0xFFD66AC2),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
