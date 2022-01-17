import 'package:auto_size_text/auto_size_text.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share2desktop/main.dart';

class Anleitung extends StatefulWidget {
  _Anleitung createState() => new _Anleitung();
}

/*final List<Widget> widgetList = [
  Column(children: [
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
  ],),
];*/
class _Anleitung extends State<Anleitung> {
  final controller = PageController(
    initialPage: 0,
  );
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final ScrollController controller2 = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(children: [
              Expanded(
                  child: ScrollConfiguration(
  behavior: AppScrollBehavior(),child: PageView(
                controller: controller,
                onPageChanged: (page) => {print(page.toString())},
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(15.0),
                      color: Colors.cyan,
                      child: Center(
                          child: 
                          Column(children: [

                          
                          Spacer(),
                          Text(
                        AppLocalizations.of(context)!
                                    .instructions1_header,
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!
                                    .instructions1,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset(
                                  'assets/share2desktop1.png', height: MediaQuery.of(context).size.height * 0.2,
                                )),

                      Spacer()
                      ]))
                      
                      
                      ),
                  Container(
                      color: Colors.green,
                      child: Center(
                          child: Text(
                        'This is Page 2',
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ))),
                  Container(
                      color: Colors.purple,
                      child: Center(
                          child: Text(
                        'This is Page 3',
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ))),
                ],
              )),
              /*ListView(
                shrinkWrap: true,
  // This next line does the trick.
  scrollDirection: Axis.horizontal, 
  children: <Widget>[
       Container(width:  MediaQuery.of(context).size.width * 0.8, child:
      Column(children:[
        Spacer(),
        Text(
               AppLocalizations.of(context)!.instructions1_header,
               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
        ),
        SizedBox(height: 20),

        Text(AppLocalizations.of(context)!.instructions1,
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline4!.color),
              textAlign: TextAlign.left,
              maxLines: 20,
              //presetFontSizes: [18, 8, 6]),
        ),
  
        SizedBox(height: 10),
        FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(
              'assets/share2desktop1.png',
              height: MediaQuery.of(context).size.height * 0.2,
            )),
        Spacer(),
      ])),
      Column(
        children: [Text("test2")],
      )
  ]
*/
     ) ])));
  }
}
           /* CarouselSlider(
                items: list,
                carouselController: _controller,
                options: CarouselOptions(
                  height: double.infinity,
                  //aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                )),
            //Text(_current.toString())
         // ]),
        //));
    );
  }
}*/
/*return Scaffold(
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
                CarouselSlider(
  options: CarouselOptions(height: 400.0),
  items: [Column(children: [Text("Test")],)] {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.amber
          ),
          child: Container(child: $i))
        );
      },
    );
  }).toList(),
)
                /*ImageSlideshow(
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
                ),*/
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
}*/
