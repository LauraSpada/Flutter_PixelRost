import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/models/user.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/providers/user_provider.dart';
import 'package:flutter_pixelroster/services/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Userformpage extends StatefulWidget {
  final UserService service;

  const Userformpage({super.key, required this.service});

  @override
  State<Userformpage> createState() => _UserformpageState();
}

class _UserformpageState extends State<Userformpage> {
  final _formKey = GlobalKey<FormState>();
  final _usrController = TextEditingController();
  final _pwdController = TextEditingController();
  final _imgController = TextEditingController();
  bool _saving = false;
  bool _obscure = true;

  @override
  void dispose() {
    _usrController.dispose();
    _pwdController.dispose();
    _imgController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final user = User(
      id: '',
      name: _usrController.text.trim(),
      password: _pwdController.text.trim(),
      image: _imgController.text.trim().isEmpty
          ? null
          : _imgController.text.trim(),
    );

    try {
      setState(() => _saving = true);
      await widget.service.createUser(user);

      if (mounted) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF350D4C) : Color(0xFFAE86C1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _imgController.text.isNotEmpty
                        ? NetworkImage(_imgController.text)
                        : null,
                    child: _imgController.text.isEmpty
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usrController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            prefixIcon: const Icon(Icons.person),
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: const Color(0xFFEBE1FF),
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Informe o nome'
                              : null,
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
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          obscureText: _obscure,
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
                        TextFormField(
                          controller: _imgController,
                          decoration: InputDecoration(
                            labelText: 'URL da Imagem',
                            prefixIcon: const Icon(Icons.image_outlined),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _saving ? null : _save,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEBE1FF),
                          ),
                          child: _saving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Criar Usuário',
                                  style: GoogleFonts.pressStart2p(fontSize: 10,
                                   color: isDarkMode
                                      ? Color(0xFFB5076B)
                                      : Color(0xFFD66AC2)),
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
