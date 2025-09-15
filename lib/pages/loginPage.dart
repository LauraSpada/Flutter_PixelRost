import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/routes.dart';
import 'package:flutter_pixelroster/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formkey = GlobalKey<FormState>();
  final _usrController = TextEditingController();
  final _pwdController = TextEditingController();
  bool _obscure = true;

  void _doLogin() {
    final user = _usrController.text.trim();
    final password = _pwdController.text.trim();

    final auth = Authentication.authenticate(user, password);

    if (auth) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
        arguments: {'user': user},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 30),
          content: Text('Usuário ou senha inválidos'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF15047C),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  Image.asset('assets/logo-dark.png'),
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
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: _doLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEBE1FF),
                            ),
                            child: Text('Entrar'),
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
