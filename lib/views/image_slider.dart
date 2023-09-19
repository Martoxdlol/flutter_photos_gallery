import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_photos_gallery/data/image_data.dart';
import 'package:flutter_photos_gallery/views/zoomable_image.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    super.key,
    required this.images,
    required this.initialIndex,
    this.onImageChanged,
  });

  final List<ImageData> images;
  final int initialIndex;
  final void Function(int)? onImageChanged;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentIndex = 0;

  final controller = CarouselController();

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CarouselSlider.builder(
        carouselController: controller,
        options: CarouselOptions(
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          initialPage: widget.initialIndex,
          aspectRatio: size.width / size.height,
          height: size.height,
          viewportFraction: 1,
          onPageChanged: (value, reason) {
            setState(() {
              currentIndex = value;
            });
            widget.onImageChanged?.call(value);
          },
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
  void Function(int)? onImageChanged,
}) {
  Navigator.of(context).push(
    ImageSliderPageRoute(
      builder: (context) => ImageSlider(
        images: images,
        initialIndex: initialIndex,
        onImageChanged: onImageChanged,
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
            child: Container(
              color: Colors.black.withOpacity(animation.value),
            ),
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
