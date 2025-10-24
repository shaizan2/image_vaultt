import 'package:hive/hive.dart';

 // not generated, kept for clarity but adapter implemented below

@HiveType(typeId: 0)
class ImageModel extends HiveObject {
  @HiveField(0)
  String path;

  @HiveField(1)
  DateTime capturedAt;

  ImageModel({required this.path, required this.capturedAt});
}

// Manual adapter implementation (so build_runner is NOT required).
class ImageModelAdapter extends TypeAdapter<ImageModel> {
  @override
  final int typeId = 0;

  @override
  ImageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return ImageModel(
      path: fields[0] as String,
      capturedAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ImageModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.capturedAt);
  }
}
