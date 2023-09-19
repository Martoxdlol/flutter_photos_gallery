import 'package:flutter/material.dart';
import 'package:flutter_photos_gallery/data/image_data.dart';

class ZoomableImageView extends StatefulWidget {
  const ZoomableImageView({super.key, required this.image});

  final ImageData image;

  @override
  State<ZoomableImageView> createState() => _ZoomableImageViewState();
}

class _ZoomableImageViewState extends State<ZoomableImageView> {
  final constroller = TransformationController();

  BoxFit fit = BoxFit.cover;

  void listener() {
    setState(() {
      if (constroller.value.row0.x <= 1.0) {
        fit = BoxFit.cover;
      } else {
        fit = BoxFit.contain;
      }
    });
  }

  @override
  void initState() {
    constroller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    constroller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InteractiveViewer(
      transformationController: constroller,
      maxScale: 1000,
      minScale: 1,
      // boundaryMargin: EdgeInsets.symmetric(horizontal: -100),
      child: widget.image.getImage(
        fit: fit,
        width: fit == BoxFit.contain ? width : null,
      ),
    );
  }
}
