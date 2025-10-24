import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/hive_manager.dart';
import '../models/image_model.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  Future<void> captureImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera, maxWidth: 1920);
    if (image != null) {
      final model = ImageModel(path: image.path, capturedAt: DateTime.now());
      await HiveManager.box.add(model);
      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Capture Image")),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.camera_alt),
          label: const Text("Capture"),
          onPressed: () => captureImage(context),
        ),
      ),
    );
  }
}
