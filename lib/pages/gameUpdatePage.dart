import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/models/game.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/services/game.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GameUpdatePage extends StatefulWidget {
  final GameService service;
  final Game game;

  const GameUpdatePage({super.key, required this.service, required this.game});

  @override
  State<GameUpdatePage> createState() => _GameUpdatePageState();
}

class _GameUpdatePageState extends State<GameUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _gmController;
  late TextEditingController _desController;
  late TextEditingController _resController;
  late TextEditingController _tpController;
  late TextEditingController _imgController;
  late TextEditingController _cmpController;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _gmController = TextEditingController(text: widget.game.name);
    _desController = TextEditingController(text: widget.game.description);
    _resController = TextEditingController(
      text: widget.game.releasedate.toString(),
    );
    _tpController = TextEditingController(text: widget.game.type);
    _imgController = TextEditingController(text: widget.game.image ?? "");
    _cmpController = TextEditingController(text: widget.game.company);
  }

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

  Future<void> _update() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final updatedGame = widget.game.copyWith(
      name: _gmController.text.trim(),
      description: _desController.text.trim(),
      releasedate: int.parse(_resController.text.trim()),
      type: _tpController.text.trim(),
      image: _imgController.text.trim(),
      company: _cmpController.text.trim(),
    );

    try {
      final savedGame = await widget.service.updateGame(updatedGame);

      if (mounted) {
        Navigator.of(context).pop(savedGame);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Game atualizado com sucesso!')),
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
      backgroundColor: isDarkMode ? Colors.black : Color(0xFFE8DAFF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      iconSize: 20,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      onPressed: _saving
                          ? null
                          : () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Confirmação'),
                                  content: const Text(
                                    'Deseja realmente excluir este jogo?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('Excluir'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                setState(() => _saving = true);
                                try {
                                  await widget.service.deleteGame(
                                    widget.game.id!,
                                  ); // chama seu serviço
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Jogo excluído com sucesso!',
                                        ),
                                      ),
                                    );
                                    Navigator.pop(
                                      context,
                                      true,
                                    ); // volta para a lista
                                  }
                                } catch (e) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Erro ao excluir: $e'),
                                      ),
                                    );
                                  }
                                } finally {
                                  if (mounted) setState(() => _saving = false);
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: isDarkMode
                            ? Colors.white
                            : Colors.black,
                        //    ? Colors.white
                        //   : Colors.black,
                      ),
                      child: Icon(
                        Icons.delete_forever,
                        color: isDarkMode
                            ? Color(0xFFB5076B)
                            : Color(0xFFFF7EC8),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.height * 0.24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 2,
                    ),
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
                const SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFF45046A) : Color(0xFF671993),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _gmController,
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                            prefixIcon: Icon(Icons.gamepad),
                            border: OutlineInputBorder(),
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
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            prefixIcon: Icon(Icons.wysiwyg_outlined),
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _resController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Ano de Lançamento',
                            prefixIcon: Icon(Icons.date_range_outlined),
                            border: OutlineInputBorder(),
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
                          decoration: const InputDecoration(
                            labelText: 'Tipo',
                            prefixIcon: Icon(Icons.widgets_outlined),
                            border: OutlineInputBorder(),
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
                          decoration: const InputDecoration(
                            labelText: 'URL da Imagem',
                            prefixIcon: Icon(
                              Icons.add_photo_alternate_outlined,
                            ),
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _cmpController,
                          decoration: const InputDecoration(
                            labelText: 'Empresa',
                            prefixIcon: Icon(Icons.business_outlined),
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Informe a empresa'
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 180,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _update,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Color(0xFFE8DAFF)
                          : Color(0xFF45046A),
                      foregroundColor: isDarkMode
                          ? Color(0xFF45046A)
                          : Color(0xFFE8DAFF),
                    ),
                    child: _saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            'Atualizar',
                            style: GoogleFonts.pressStart2p(
                              fontSize: 10,
                              color: isDarkMode
                                  ? Color(0xFF45046A)
                                  : Color(0xFFE8DAFF),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
