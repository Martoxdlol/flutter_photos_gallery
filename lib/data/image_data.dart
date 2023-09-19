import 'dart:io';

import 'package:flutter/material.dart';

class ImageData {
  ImageData();

  final tag = UniqueKey();

  Widget getImage({double? width, double? height, BoxFit? fit}) =>
      const Placeholder();
}

class LocalImageData extends ImageData {
  LocalImageData({required this.path});

  final Uri path;

  @override
  Widget getImage({double? width, double? height, BoxFit? fit}) {
    return Hero(
      tag: tag,
      child: Image.file(
        File.fromUri(path),
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
