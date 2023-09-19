import 'package:flutter/material.dart';
import 'package:flutter_photos_gallery/data/image_data.dart';
import 'package:flutter_photos_gallery/data/provider.dart';
import 'package:flutter_photos_gallery/views/image_slider.dart';
import 'package:flutter_photos_gallery/widgets/image_renderer.dart';

class GalleryHome extends StatefulWidget {
  const GalleryHome({super.key});

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  List<ImageData> images = [];

  final controller = ScrollController();

  void addImage(ImageData image) {
    setState(() {
      images.add(image);
    });
  }

  @override
  void initState() {
    DataProvider.instance
        .photosLibrary()
        .then((value) => value.images.listen(addImage));

    super.initState();
  }

  void setCurrentImageIndex(int index) {
    final (itemWidth, itemsPerRow, width, height, rowsQuantity) = dimensions;

    final rowIndex = (index / itemsPerRow).floor();

    controller.jumpTo(rowIndex * itemWidth - height / 2);
  }

  (
    double itemWidth,
    int itemsPerRow,
    double width,
    double height,
    int rowsQuantity
  ) get dimensions {
    final width = MediaQuery.of(context).size.width;

    final height = MediaQuery.of(context).size.height;

    final itemsPerRow = (width / 200).floor();

    final itemWidth = width / itemsPerRow;

    final rowsQuantity = (images.length / itemsPerRow).ceil();

    return (itemWidth, itemsPerRow, width, height, rowsQuantity);
  }

  @override
  Widget build(BuildContext context) {
    final (itemWidth, itemsPerRow, _, _, rowsQuantity) = dimensions;

    return Scaffold(
      body: ListView.builder(
        controller: controller,
        itemCount: rowsQuantity,
        itemExtent: itemWidth,
        itemBuilder: (context, index) {
          return Row(
            children: [
              for (var i = 0; i < itemsPerRow; i++)
                if (index * itemsPerRow + i < images.length)
                  ImageRenderer(
                    image: images[index * itemsPerRow + i],
                    width: itemWidth,
                    height: itemWidth,
                    onTap: () {
                      showImageSlider(
                        context,
                        images: images,
                        initialIndex: index * itemsPerRow + i,
                        onImageChanged: setCurrentImageIndex,
                      );
                    },
                  )
            ],
          );
        },
      ),
    );
  }
}
