import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_vault/core/hive_manager.dart' show HiveManager;
import '../models/image_model.dart';

class ImageDetailScreen extends StatefulWidget {
  final ImageModel image;
  const ImageDetailScreen({super.key, required this.image});

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  late final Box<ImageModel> box;

  @override
  Widget build(BuildContext context) {
    final box = HiveManager.box;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Detail"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await widget.image.delete();
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<ImageModel> box, _) {
          final images = box.values.toList().reversed.toList();

          final updatedImage = box.get(widget.image.key)!;
          return Column(
            children: [
              Expanded(
                child: Image.file(File(updatedImage.path), fit: BoxFit.contain),
              ),SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Captured: ${updatedImage.capturedAt.toLocal()}"),
              ),
            ],
          );
        },
      ),
    );
  }
}
