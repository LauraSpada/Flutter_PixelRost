import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/models/game.dart';
import 'package:flutter_pixelroster/pages/gameListPage.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/services/game.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Gamecreatepage extends StatefulWidget {
  final GameService service;

  const Gamecreatepage({super.key, required this.service});

  @override
  State<Gamecreatepage> createState() => _GamecreatepageState();
}

class _GamecreatepageState extends State<Gamecreatepage> {
  final _formKey = GlobalKey<FormState>();
  final _gmController = TextEditingController();
  final _desController = TextEditingController();
  final _resController = TextEditingController();
  final _tpController = TextEditingController();
  final _imgController = TextEditingController();
  final _cmpController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _gmController.dispose();
    _desController.dispose();
    _resController.dispose();
    _tpController.dispose();
    _imgController.dispose();
    _cmpController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final game = Game(
      name: _gmController.text.trim(),
      description: _desController.text.trim(),
      releasedate: int.parse(_resController.text.trim()),
      type: _tpController.text.trim(),
      image: _imgController.text.trim(),
      company: _cmpController.text.trim(),
    );

    try {
      setState(() => _saving = true);
      await widget.service.createGame(game);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Gamelistpage(gameService: GameService()),
          ),
        );
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
      backgroundColor: isDarkMode ? Color(0xFF45046A) : Color(0xFF671993),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBE1FF),
                      borderRadius: BorderRadius.circular(5),
                      image: _imgController.text.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(_imgController.text),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _imgController.text.isEmpty
                        ? const Icon(
                            Icons.gamepad,
                            size: 50,
                            color: Colors.deepPurple,
                          )
                        : null,
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _gmController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            prefixIcon: const Icon(Icons.gamepad),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Informe o nome'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _desController,
                          decoration: InputDecoration(
                            labelText: 'Descrição',
                            prefixIcon: const Icon(Icons.wysiwyg_outlined),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _resController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Data de Lançamento',
                            prefixIcon: const Icon(Icons.date_range_outlined),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Informe o ano de lançamento';
                            }
                            if (int.tryParse(v.trim()) == null) {
                              return 'Digite apenas números';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _tpController,
                          decoration: InputDecoration(
                            labelText: 'Tipo',
                            prefixIcon: const Icon(Icons.widgets_outlined),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Informe o tipo'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _imgController,
                          decoration: InputDecoration(
                            labelText: 'URL da Imagem',
                            prefixIcon: const Icon(
                              Icons.add_photo_alternate_outlined,
                            ),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _cmpController,
                          decoration: InputDecoration(
                            labelText: 'Empresa',
                            prefixIcon: const Icon(Icons.business_outlined),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Informe o tipo'
                              : null,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _saving ? null : _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEBE1FF),
                              foregroundColor: const Color(0xFF7136BE),
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
                                    'Salvar',
                                    style: GoogleFonts.pressStart2p(
                                      fontSize: 10,
                                      color: const Color(0xFF7136BE),
                                    ),
                                  ),
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
