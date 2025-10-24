import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Make sure this import is present
import '../core/hive_manager.dart';
import '../models/image_model.dart';
import 'image_detail_screen.dart';
import 'camera_screen.dart';
import 'settings_screen.dart';

class ImageListScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const ImageListScreen({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gallery"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SettingsScreen(onThemeToggle: onThemeToggle),
              ),
            ),
          ),
        ],
      ),

      /// 👇 FIXED: Typed ValueListenableBuilder for Box<ImageModel>
      body: ValueListenableBuilder<Box<ImageModel>>(
        valueListenable: HiveManager.box.listenable(),
        builder: (context, box, _) {
          final images = box.values.toList().cast<ImageModel>().reversed.toList();

          if (images.isEmpty) {
            return const Center(child: Text("No images yet"));
          }

          // Responsive crossAxisCount
          int crossAxisCount;
          final width = MediaQuery.of(context).size.width;
          if (width < 600) {
            crossAxisCount = 3;
          } else if (width < 900) {
            crossAxisCount = 4;
          } else {
            crossAxisCount = 6;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: images.length,
            itemBuilder: (_, i) {
              final img = images[i];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImageDetailScreen(image: img),
                  ),
                ),
                child: Image.file(
                  File(img.path),
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CameraScreen()),
        ),
      ),
    );
  }
}
