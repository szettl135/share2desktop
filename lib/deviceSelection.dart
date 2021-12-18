import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share2desktop/chooseFiles.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:share2desktop/deviceInfo.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeviceSelection extends StatefulWidget {
  const DeviceSelection({Key? key}) : super(key: key);

  @override
  _DeviceSelection createState() => _DeviceSelection();
}

class _DeviceSelection extends State<DeviceSelection> {
  //bool isSwitched = false;
  Object? selectedDevice = null;
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  Future<void> _aboutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Über die App",
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                Text("Von Team Share2Desktop"),
                RichText(
                    text: new TextSpan(
                  text: 'share2desktop.com',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch('http://share2desktop.com/');
                    },
                )),
                Text("2021-12-13")
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _qrDialog() async {
    var deviceData = await getDeviceInfo();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Dein QR-Code',
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                Container(child: getQRCodeImage(deviceData.id), width: 400),
                /*Image(
                    image: AssetImage("assets/qrtest.png"),
                    alignment: Alignment.center,
                    width: 400),*/
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectTheme() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Wähle ein Theme',
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                TextButton(
                    child: Text("Helles Erscheinungsbild"),
                    onPressed: () {
                      AdaptiveTheme.of(context).setLight();
                    }),
                SizedBox(height: 10),
                TextButton(
                    child: Text("Dunkles Erscheinungsbild"),
                    onPressed: () {
                      AdaptiveTheme.of(context).setDark();
                    }),

                //TextButton(child: Text("mspaint"), onPressed:  () {_notifier.value = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light}),
              ],
            ),
          ),
        );
      },
    );
  }

  final names = [
    'Lennarts Desktop',
    'Jonas Google Pixel 3',
    'iPhone SE von David',
    'Sebis Laptop',
    'Christians MacBook Pro',
    'Denis PCs',
    'Alex Computer',
    'Lennarts DesktopLennarts Desktop',
    'Bladees Handy'
    //'Christians MacBook ProChristians MacBook ProChristians MacBook Pro'
  ];

  final icons = [
    Icons.computer,
    Icons.computer,
    Icons.phone_iphone,
    Icons.phone_iphone,
    Icons.computer,
    Icons.phone_iphone,
    Icons.phone_iphone,
    Icons.phone_iphone,
    Icons.phone_iphone
  ];

  var devicesGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Text('Share2Desktop'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: const Text('Einstellungen'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.visibility),
                title: const Text('Aussehen'),
                onTap: () {
                  _selectTheme();
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: const Text('Über die App'),
                onTap: () {
                  _aboutDialog();
                  //das pop würden den dialog deleten
                  //Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Column(children: [
          //Einstellungen
          /*Row(
            children: [
              Spacer(flex: 1),
              Container(
                  //width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    child: Row(children: [
                      Icon(Icons.qr_code),
                      SizedBox(width: 10),
                      Text("Dein Gerät", style: Theme.of(context).textTheme.headline4),
                    ]),
                    onPressed: () => {_qrDialog()},
                  )),
              Spacer(flex: 1)
            ],
          ),*/
          SizedBox(height: 20),
          Row(
            children: [
              Spacer(flex: 1),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              padding: EdgeInsets.all(12)),
                          onPressed: () => {_qrDialog()},
                          //shape:RectangleBorder(
                          //borderRadius: BorderRadius.circular(16))),
                          child: Row(
                            children: [
                              Icon(Icons.qr_code,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .color),
                              SizedBox(width: 10),
                              Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: AutoSizeText(AppLocalizations.of(context)!.yourDevice,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      minFontSize: 0,
                                      maxFontSize: 30,
                                      //presetFontSizes: [30, 15, 5],
                                      stepGranularity: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4)),
                              SizedBox(width: 10),
                              Icon(Icons.qr_code, color: Colors.transparent),
                            ],
                          )),
                      Expanded(
                        child: IconButton(
                            onPressed: () => (print("camera")),
                            iconSize: 40.0,
                            icon: Icon(Icons.photo_camera)),
                      ),
                    ],
                  )),
              Spacer(flex: 1)
            ],
          ),

          //Abstand
          Spacer(flex: 1),
          AutoSizeText("Geräte in der Nähe: ",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center),
          SizedBox(height: 20),
          Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: names.length,
                itemExtent: MediaQuery.of(context).size.height * 0.125,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).scaffoldBackgroundColor,

                    //
                    //                 <-- Card widget
                    shape: ContinuousRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // if you need this
                      side: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                        leading: Container(
                            height: double.infinity, child: Icon(icons[index])),
                        trailing: Container(
                            height: double.infinity,
                            child: Icon(Icons.arrow_right_alt)),
                        title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: AutoSizeText(
                                        names[index],
                                        //style: Theme.of(context)
                                        //.textTheme
                                        // .headline3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        //maxLines: 3,
                                        maxLines: 1,
                                        //presetFontSizes: [25, 15, 5],
                                        //minFontSize: 0,
                                        group: devicesGroup,
                                        //overflowReplacement: Text(names[index].substring(0,2)+"..."),
                                        maxFontSize: 25,
                                        stepGranularity: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              )

                              /*Icon(icons[index]), SizedBox(width: 30),*/ /*, SizedBox(width: 30)*/
                            ]),
                        //subtitle: Text(subtitles[index]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChooseFiles(
                                    targetDeviceName: names[index],
                                  )));
                        }),
                  );
                },
              )),
          //Row(children: [
          //SizedBox(width: 100),
          /*Container(
            
              padding: EdgeInsets.all(50),
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  //https://protocoderspoint.com/flutter-listview-ontap-selected-item-send-data-to-new-screen/
                  //Weiter button weg und einfach wen man device wählt weiter
                  //jo das passt mal wir brauchen noch dynamisches adden dieser dinger damit das workt

                  ListTile(
                      leading: const Icon(Icons.computer),
                      title: const Text("Computer 1"),
                      subtitle: Text("Windows-PC von JUMBO"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChooseFiles(
                                  targetDeviceName: 'computer 1',
                                )));
                      }),
                  ListTile(
                      leading: const Icon(Icons.computer),
                      title: const Text("Computer 2"),
                      subtitle: Text("Windows-PC von Schreiner"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChooseFiles(
                                  targetDeviceName: 'computer 2',
                                )));
                      }),
                  ListTile(
                      leading: const Icon(Icons.phone_iphone),
                      title: const Text("Smartphone"),
                      subtitle: Text("iPhone von Fabian"),
                      onTap: () {
                        print("bc 1");
                      }),
                  ListTile(
                      leading: const Icon(Icons.phone_iphone),
                      title: const Text("Smartphone"),
                      subtitle: Text("iPhone SE von Lennart"),
                      onTap: () {
                        print("bc 1");
                      }),
                  ListTile(
                      leading: const Icon(Icons.phone_iphone),
                      title: const Text("Smartphone"),
                      subtitle: Text("iPhone 12 von Lennart"),
                      onTap: () {
                        print("bc 1");
                      }),
                ],
              )),

          //],

          //),*/
          SizedBox(height: 20),
          /*OutlinedButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseFiles()),
                    )
                  },
              child: Text("Weiter"))*/
          Spacer(flex: 1),
        ]));
  }

  QrImage getQRCodeImage(data) {
    return QrImage(
      data: data,
      version: QrVersions.auto,
      gapless: false,
      //embeddedImage: AssetImage('assets/icon.png'),
      backgroundColor: Color(0xffFFFFFF),
    );
  }
}
