import 'dart:io';

import 'package:flutter_photos_gallery/data/collection.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:path_provider_windows/src/folders.dart' as folders;

class DataProvider {
  Future<String> getLibraryPath() async {
    final provider = PathProviderWindows();
    return (await provider.getPath(folders.WindowsKnownFolder.Pictures))!;
  }

  Future<GalleryCollection> photosLibrary() async {
    return LocalGalleryCollection(directory: Directory(await getLibraryPath()));
  }

  static final instance = DataProvider();
}
