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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final itemsPerRow = (width / 200).floor();

    final itemWidth = width / itemsPerRow;

    final rowsQuantity = (images.length / itemsPerRow).ceil();

    return Scaffold(
      body: ListView.builder(
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
