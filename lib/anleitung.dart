import 'package:auto_size_text/auto_size_text.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share2desktop/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        body: Column(children: [
          Expanded(
            flex: 5,
            child: PageView(
                controller: controller,
                onPageChanged: (page) => {_current = page},
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(20.0),
                      color: Colors.cyan,
                      child: Center(
                          child: Column(children: [
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.instructions1_header,
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.instructions1,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                            child: Image.asset(
                          'assets/share2desktop1.png',
                          height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.contain,
                        )),
                        Spacer()
                      ]))),
                  Container(
                      padding: EdgeInsets.all(15.0),
                      color: Colors.green,
                      child: Center(
                          child: Column(children: [
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.instructions2_header,
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.instructions2,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer()
                      ]))),
                  Container(
                      padding: EdgeInsets.all(15.0),
                      color: Colors.purple,
                      child: Center(
                        child: Column(children: [
                          Spacer(),
                          Text(
                            AppLocalizations.of(context)!.instructions3_header,
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!.instructions3,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer()
                        ]),
                      )),
                  Container(
                      padding: EdgeInsets.all(15.0),
                      color: Colors.orange,
                      child: Center(
                        child: Column(children: [
                          Spacer(),
                          Text(
                            AppLocalizations.of(context)!.instructions4_header,
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!.instructions4,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer()
                        ]),
                      )),
                ]),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.01),
          Center(
              child: SmoothPageIndicator(
                  controller: controller, // PageController
                  count: 4,
                  effect: WormEffect(), // your preferred effect
                  onDotClicked: (index) {
                    controller.jumpToPage(index);
                  })),
          SizedBox(height: MediaQuery.of(context).size.width * 0.01),
        ]));
  }
}
