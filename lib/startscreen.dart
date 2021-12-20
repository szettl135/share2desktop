import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final smallGroup = AutoSizeGroup();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(children: [
              //Abstand
              Spacer(flex: 1),

              //Logo und Titel
              AutoSizeText("Willkommen bei",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline4!.color),
                  group: smallGroup,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  presetFontSizes: [22, 12, 6]),
              SizedBox(height: 20),
              AutoSizeText("Share2Desktop",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline4!.color),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  presetFontSizes: [32, 16, 10]),
              //SizedBox(height: 20),
              Divider(
                color: Theme.of(context).textTheme.headline4!.color, //color of divider
                height: 5, //height spacing of divider
                thickness: 3, //thickness of divier line
                indent: 25, //spacing at the start of divider
                endIndent: 25, //spacing at the end of divider
              ),

              AutoSizeText("Installieren Sie bitte die Share2Desktop App auch auf Ihrem anderen Gerät.",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline4!.color),
                  group: smallGroup,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  presetFontSizes: [22, 12, 6]),

              Spacer(flex: 1),
            ])));
  }
}
