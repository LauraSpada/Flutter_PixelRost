import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/providers/theme_provider.dart';
import 'package:flutter_pixelroster/providers/user_provider.dart';
import 'package:flutter_pixelroster/widgets/appMenuDrawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

     if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Nenhum usuário logado")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configurações",
          style: GoogleFonts.pressStart2p(fontSize: 15),
        ),
        actions: [
          Icon(
            isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            color: isDarkMode ? Colors.white : Colors.black,
            size: 25,
          ),
          const SizedBox(width: 8),
          Switch(
            value: isDarkMode,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.black,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      drawer: Appmenudrawer(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          height: MediaQuery.of(context).size.height * 0.70,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFFB5076B) : Color(0xFFFF7EC8),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        (user.image != null && user.image!.isNotEmpty)
                        ? NetworkImage(user.image!)
                        : null,
                    child: (user.image == null || user.image!.isEmpty)
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(user.name, style: const TextStyle(fontSize: 20)),
                  Text('ID: ${user.id}', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
