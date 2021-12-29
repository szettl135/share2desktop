import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';

class Anleitung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Container(
            padding: EdgeInsets.all(15.0),
            child: ImageSlideshow(

          /// Width of the [ImageSlideshow].
          width: double.infinity,

          /// Height of the [ImageSlideshow].
          height: MediaQuery.of(context).size.height * 0.5,

          /// The page to show when first creating the [ImageSlideshow].
          initialPage: 0,

          /// The color to paint the indicator.
          indicatorColor: Colors.blue,

          /// The color to paint behind th indicator.
          indicatorBackgroundColor: Colors.grey,

          /// The widgets to display in the [ImageSlideshow].
          /// Add the sample image file into the images folder
          children: [
            Image.asset(
              'assets/slideshow1.png',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/slideshow2.png',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/slideshow3.png',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/slideshow4.png',
              fit: BoxFit.cover,
            ),
          ],

          /// Called whenever the page in the center of the viewport changes.
          onPageChanged: (value) {
            print('Page changed: $value');
          },

          /// Auto scroll interval.
          /// Do not auto scroll with null or 0.
          autoPlayInterval: 0,

          /// Loops back to first slide.
          isLoop: false,
        ),
      ),
      
    );
  }

}