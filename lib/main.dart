import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_vault/models/image_model.dart' show ImageModelAdapter, ImageModel;
import 'core/hive_manager.dart';
import 'screens/image_list_screen.dart';
import 'core/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await HiveManager.init();
  // Hive.registerAdapter(ImageModelAdapter()); // your model adapter
  // await Hive.openBox<ImageModel>('images');
  runApp(const ImageVaultApp());
}

class ImageVaultApp extends StatefulWidget {
  const ImageVaultApp({super.key});

  @override
  State<ImageVaultApp> createState() => _ImageVaultAppState();
}

class _ImageVaultAppState extends State<ImageVaultApp> {
  bool isDark = false;

  void toggleTheme() => setState(() => isDark = !isDark);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ImageVault',
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: ImageListScreen(onThemeToggle: toggleTheme),
    );
  }
}
