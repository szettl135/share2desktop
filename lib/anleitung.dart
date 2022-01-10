import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Anleitung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Share2Desktop")),
      body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  color: Theme.of(context)
                      .textTheme
                      .headline4!
                      .color, //color of divider
                  height: 5, //height spacing of divider
                  thickness: 3, //thickness of divier line
                  indent: MediaQuery.of(context).size.width *
                      0.1, //spacing at the start of divider
                  endIndent: MediaQuery.of(context).size.width *
                      0.1, //spacing at the end of divider
                ),
                ImageSlideshow(
                  /// Width of the [ImageSlideshow].
                  width: double.infinity,

                  /// Height of the [ImageSlideshow].
                  height: MediaQuery.of(context).size.height * 0.7,

                  /// The page to show when first creating the [ImageSlideshow].
                  initialPage: 0,

                  /// The color to paint the indicator.
                  indicatorColor: Colors.blue,

                  /// The color to paint behind th indicator.
                  indicatorBackgroundColor: Colors.grey,

                  /// The widgets to display in the [ImageSlideshow].
                  /// Add the sample image file into the images folder
                  children: [
                    //1 page
                    /*Container(
                      
                        width:  MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.7,
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Expanded(child: 
                            AutoSizeText(
                                AppLocalizations.of(context)!
                                    .instructions1_header,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .color),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                presetFontSizes: [24, 10, 6])),
                            SizedBox(height: 10),
                            Expanded(child: 
                            AutoSizeText(
                                AppLocalizations.of(context)!
                                    .instructions1,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .color),
                                textAlign: TextAlign.left,
                                maxLines: 8,
                                presetFontSizes: [18, 8, 6]),
                            ),
                            SizedBox(height: 10),
                            FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                  'assets/share2desktop1.png', height: MediaQuery.of(context).size.height * 0.2,
                                )),
                          ],
                        )),*/
                    Container(child: Column(children: [
                      
                            Text(
                                AppLocalizations.of(context)!
                                    .instructions1_header,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .color),
                                textAlign: TextAlign.left),
                            SizedBox(height: 10),
      
                            Text(
                                AppLocalizations.of(context)!
                                    .instructions1,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .color),
                                textAlign: TextAlign.left),
                            
                            SizedBox(height: 10),
                            FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                  'assets/share2desktop1.png', height: MediaQuery.of(context).size.height * 0.2,
                                )),
                    ],)),
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
                Divider(
                  color: Theme.of(context)
                      .textTheme
                      .headline4!
                      .color, //color of divider
                  height: 5, //height spacing of divider
                  thickness: 3, //thickness of divier line
                  indent: MediaQuery.of(context).size.width *
                      0.1, //spacing at the start of divider
                  endIndent: MediaQuery.of(context).size.width *
                      0.1, //spacing at the end of divider
                ),
              ])),
    );
  }
}
