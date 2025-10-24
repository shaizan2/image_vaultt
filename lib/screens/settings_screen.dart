import 'package:flutter/material.dart';
import '../core/hive_manager.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;
  const SettingsScreen({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Toggle Theme"),
            trailing: const Icon(Icons.brightness_6),
            onTap: onThemeToggle,
          ),
          ListTile(
            title: const Text("Clear All Images"),
            trailing: const Icon(Icons.delete_forever),
            onTap: () async {
              await HiveManager.box.clear();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All images deleted!"))
                );
              }
            },
          ),
          const ListTile(
            title: Text("App Info"),
            subtitle: Text("Version 1.0 • Built with Flutter and Hive"),
          ),
        ],
      ),
    );
  }
}
