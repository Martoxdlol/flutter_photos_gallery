import 'dart:io';

import 'package:flutter_photos_gallery/data/image_data.dart';

abstract class GalleryCollection {
  Stream<ImageData> get images;
}

class LocalGalleryCollection extends GalleryCollection {
  LocalGalleryCollection({required this.directory});

  final Directory directory;

  @override
  Stream<ImageData> get images async* {
    await for (final entity in directory.list()) {
      final stat = await entity.stat();

      if (stat.type != FileSystemEntityType.file) continue;

      final path = entity.path.toLowerCase();

      final extensions = [
        '.jpg',
        '.jpeg',
        '.png',
        '.gif',
        '.webp',
        '.bmp',
        '.wbmp',
        '.heic',
        '.heif',
        '.tiff',
        '.ico',
        // '.cur',
        // '.psd',
        // '.ai',
        '.svg',
        '.jfif',
        '.jpe',
        '.avif',
      ];

      if (!extensions.any((element) => path.endsWith(element))) continue;

      yield LocalImageData(path: directory.uri.resolve(entity.path));
    }
  }
}
