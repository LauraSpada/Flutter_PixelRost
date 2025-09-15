import 'package:flutter/material.dart';
import 'package:flutter_pixelroster/routes.dart';

class Appmenudrawer extends StatelessWidget {
  const Appmenudrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.extension),
            title: Text("Configurações"),
            onTap: () => {Navigator.pushNamed(context, AppRoutes.user)},
          ),
        ],
      ),
    );
  }
}
