import 'package:hive_flutter/hive_flutter.dart';
import '../models/image_model.dart';

class HiveManager {
  static const String boxName = 'imagesBox';
  static late Box<ImageModel> _box;

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapter only once
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ImageModelAdapter());
    }

    // Open the box
    _box = await Hive.openBox<ImageModel>(boxName);
  }

  // Getter for the box
  static Box<ImageModel> get box => _box;
}
