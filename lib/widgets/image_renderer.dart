import 'package:flutter/material.dart';
import 'package:flutter_photos_gallery/data/image_data.dart';

class ImageRenderer extends StatelessWidget {
  const ImageRenderer({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.onTap,
  });

  final ImageData image;
  final double? width;
  final double? height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final imageWidget =
        image.getImage(width: width, height: height, fit: BoxFit.cover);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Stack(children: [
            Container(color: const Color.fromRGBO(127, 127, 127, 1)),
            imageWidget
          ]),
        ),
      ),
    );
  }
}
