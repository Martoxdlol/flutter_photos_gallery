import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_photos_gallery/data/image_data.dart';
import 'package:flutter_photos_gallery/views/zoomable_image.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  final List<ImageData> images;
  final int initialIndex;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CarouselSlider.builder(
        options: CarouselOptions(
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          initialPage: widget.initialIndex,
          aspectRatio: size.width / size.height,
          height: size.height,
          viewportFraction: 1,
        ),
        itemCount: widget.images.length,
        itemBuilder: (context, index, realIndex) {
          return ZoomableImageView(image: widget.images[index]);
        },
      ),
    );
  }
}

void showImageSlider(
  BuildContext context, {
  required List<ImageData> images,
  required int initialIndex,
}) {
  Navigator.of(context).push(
    ImageSliderPageRoute(
      builder: (context) => ImageSlider(
        images: images,
        initialIndex: initialIndex,
      ),
    ),
  );
}

class ImageSliderPageRoute extends PageRoute {
  ImageSliderPageRoute({required this.builder});

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'close';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.black.withOpacity(animation.value)),
          ),
        ),
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
