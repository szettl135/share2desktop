import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share2desktop/deviceSelection.dart';
import 'package:url_launcher/url_launcher.dart';

class StartScreen extends StatelessWidget {
  final smallGroup = AutoSizeGroup();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Container(
            padding: EdgeInsets.all(15.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //Abstand
              Spacer(flex: 1),

              //Logo und Titel
              Container(
                
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AutoSizeText("Willkommen bei",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline4!.color),
                      group: smallGroup,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      presetFontSizes: [22, 12, 6])),
              SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AutoSizeText("Share2Desktop",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline4!.color),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      presetFontSizes: [32, 16, 10])),
              SizedBox(height: 20),
              Divider(
                color: Theme.of(context)
                    .textTheme
                    .headline4!
                    .color, //color of divider
                height: 5, //height spacing of divider
                thickness: 3, //thickness of divier line
                indent: MediaQuery.of(context).size.width * 0.1, //spacing at the start of divider
                endIndent: MediaQuery.of(context).size.width * 0.1, //spacing at the end of divider
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AutoSizeText(
                    "Installieren Sie bitte die Share2Desktop App auch auf Ihrem anderen Gerät.",
                    style: TextStyle(color: Theme.of(context).textTheme.headline4!.color),
                    group: smallGroup,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    presetFontSizes: [22, 12, 6]),
              ),
              SizedBox(height: 10),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AutoSizeText.rich(
                    TextSpan(
                      text: 'Anleitung',
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('http://share2desktop.com/');
                        },
                    ),
                    style: TextStyle(color: Colors.blue),
                    presetFontSizes: [22, 12, 6],
                     group: smallGroup,
                  )),

              Spacer(flex: 2),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DeviceSelection()));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: AutoSizeText("Weiter",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 5,
                          maxFontSize: 30,
                          stepGranularity: 1,
                          style: Theme.of(context).textTheme.headline3))),
                          SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Spacer(flex:1),Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: AutoSizeText.rich(
                    TextSpan(
                      text: 'Nutzungsbedingungen',
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('http://share2desktop.com/');
                        },
                    ),
                    style: TextStyle(color: Colors.blue),
                    group: smallGroup,
                    textAlign: TextAlign.center,
                    presetFontSizes: [22, 12, 6],
                    maxLines: 1,
                  )),
                 // Spacer(flex:1),
                 SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  //VerticalDivider(),
                  Text("|"),
                  //Spacer(flex:1),
                   SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: AutoSizeText.rich(
                    TextSpan(
                      text: 'Datenschutzerklärung',
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('http://share2desktop.com/');
                        },
                    ),
                    maxLines: 1,
                    group: smallGroup,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                    presetFontSizes: [22, 12, 6],
                  )),
                  Spacer(flex:1)],
            ),
            SizedBox(height: 50)
            ])));
  }
}
