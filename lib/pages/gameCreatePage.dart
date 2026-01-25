import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/models/game.dart';
import 'package:flutter_pixelroster/pages/gameListPage.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/services/game.dart';
import 'package:google_fonts/google_fonts.dart';
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
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Create", style: GoogleFonts.pressStart2p(fontSize: 15)),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.height * 0.20,
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
                      ? Icon(
                          Icons.videogame_asset,
                          size: 40,
                          color: isDarkMode
                              ? Color(0xFFB5076B)
                              : Color(0xFFFF7EC8),
                        )
                      : null,
                ),
                const SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFF350D4C) : Color(0xFFAE86C1),
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
                          controller: _gmController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: const Icon(Icons.gamepad),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Name' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _desController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            prefixIcon: const Icon(Icons.wysiwyg_outlined),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _resController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Release Date',
                            prefixIcon: const Icon(Icons.date_range_outlined),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Release Year';
                            }
                            if (int.tryParse(v.trim()) == null) {
                              return 'Only Numbers';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _tpController,
                          decoration: InputDecoration(
                            labelText: 'Type',
                            prefixIcon: const Icon(Icons.widgets_outlined),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Type' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _imgController,
                          decoration: InputDecoration(
                            labelText: 'Image URL',
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
                          controller: _cmpController,
                          decoration: InputDecoration(
                            labelText: 'Company',
                            prefixIcon: const Icon(Icons.business_outlined),
                            border: const OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Company'
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
                    onPressed: _saving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Color(0xFF350D4C)
                          : Color(0xFFAE86C1),
                      foregroundColor: isDarkMode
                          ? Color(0xFFAE86C1)
                          : Color(0xFF350D4C),
                    ),
                    child: _saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            'Save',
                            style: GoogleFonts.pressStart2p(
                              fontSize: 10,
                              color: isDarkMode
                                  ? Color(0xFFAE86C1)
                                  : Color(0xFF350D4C),
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
