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
  late bool _favorite;
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
    _favorite = widget.game.favorite;
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
      favorite: _favorite,
    );

    try {
      final savedGame = await widget.service.updateGame(updatedGame);

      if (mounted) {
        Navigator.of(context).pop(savedGame);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Game successfully updated!')),
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
        title: Text("Update", style: GoogleFonts.pressStart2p(fontSize: 15)),
        actions: [ 
          IconButton(
            icon: Icon(
              _favorite ? Icons.star : Icons.star_border,
              color: _favorite ? Colors.amber : Colors.amber,
            ),
            onPressed: () {
              setState(() {
                _favorite = !_favorite;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkResponse(
               child: Icon(
                  Icons.delete_forever_outlined,
                  size: 22,
                  color: isDarkMode ? Color(0xFFB5076B) : Color(0xFFFF7EC8),
                ),
              radius: 22,
              onTap: _saving
                  ? null
                  : () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text(
                            'Do you really want to delete this game?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        setState(() => _saving = true);

                        try {
                          await widget.service.deleteGame(widget.game.id!);

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Game successfully deleted!'),
                            ),
                          );

                          Navigator.pop(context, true);
                        } catch (e) {
                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error deleting: $e')),
                          );
                        } finally {
                          if (mounted) {
                            setState(() => _saving = false);
                          }
                        }
                      }
                    },
              ),
            ),
        ],
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
                          color: isDarkMode ? Color(0xFFB5076B) : Color(0xFFFF7EC8),
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
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.gamepad),
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Name'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _desController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            prefixIcon: Icon(Icons.wysiwyg_outlined),
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _resController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Release Date',
                            prefixIcon: Icon(Icons.date_range_outlined),
                            border: OutlineInputBorder(),
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
                          decoration: const InputDecoration(
                            labelText: 'Type',
                            prefixIcon: Icon(Icons.widgets_outlined),
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Type'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _imgController,
                          decoration: const InputDecoration(
                            labelText: 'Image URL',
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
                          controller: _cmpController,
                          decoration: const InputDecoration(
                            labelText: 'Company',
                            prefixIcon: Icon(Icons.business_outlined),
                            border: OutlineInputBorder(),
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
                    onPressed: _saving ? null : _update,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Color(0xFF350D4C) : Color(0xFFAE86C1),
                      foregroundColor: isDarkMode ? Color(0xFFAE86C1)  : Color(0xFF350D4C),
                    ),
                    child: _saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            'Update',
                            style: GoogleFonts.pressStart2p(
                              fontSize: 10,
                              color: isDarkMode ? Color(0xFFAE86C1) : Color(0xFF350D4C),
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
