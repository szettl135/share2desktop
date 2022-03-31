import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share2desktop/anleitung.dart';
import 'package:share2desktop/main.dart';

import 'package:share2desktop/chooseFiles.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:share2desktop/connectionLost.dart';
import 'package:share2desktop/connectionObject.dart';
import 'package:share2desktop/deviceInfo.dart';
import 'package:share2desktop/main.dart';
import 'package:share2desktop/settings.dart';
import 'package:share2desktop/startscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeviceSelection extends StatefulWidget {
  const DeviceSelection({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    aDeviceSelection? state =
        context.findAncestorStateOfType<aDeviceSelection>();
    state!.changeLanguage(newLocale);
  }

  @override
  aDeviceSelection createState() => aDeviceSelection();
}

class aDeviceSelection extends State<DeviceSelection> {
  late Locale _locale;
  final txtController = TextEditingController();
  @override

  ///Sets up everything at the start of the app
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    txtController.dispose();
    super.dispose();
  }

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Future<void> connectionLostPopup() async {
    dialogOpen = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.grey[350],
            //title: const Text('AlertDialog Title'),
            content: Container(
                color: Colors.grey[350],
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Icon(
                        Icons.warning,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.black,
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: AutoSizeText(
                              AppLocalizations.of(context)!.connectionLost,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 16,
                              maxFontSize: 30,
                              stepGranularity: 1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      OutlinedButton(
                        onPressed: () => {},
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: AutoSizeText(
                                    AppLocalizations.of(context)!.reconnect,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    minFontSize: 12,
                                    maxFontSize: 25,
                                    stepGranularity: 1,
                                    style: TextStyle(color: Colors.black)))),
                      ),
                    ]))));
      },
    ).then((value) => dialogOpen = false);
  }

  Future unsetShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', false);
  }

  //bool isSwitched = false;
  Object? selectedDevice = null;
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  Future<void> _aboutDialog() async {
    dialogOpen = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.aboutTheApp,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                Text(AppLocalizations.of(context)!.fromTeamS2D),
                SizedBox(height: 20),
                RichText(
                    text: new TextSpan(
                  text: 'share2desktop.com',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch('http://share2desktop.com/');
                    },
                )),
                SizedBox(height: 20),
                Text("2022-03-13")
              ],
            ),
          ),
        );
      },
    ).then((value) => dialogOpen = false);
  }

  Future<void> _qrDialog() async {
    dialogOpen = true;
    var deviceData = await getDeviceInfo();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SelectableText(
                    AppLocalizations.of(context)!.yourQR +
                        " : " +
                        Provider.of<ConnectionObject>(context).internalSocketId,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                Container(
                    child: getQRCodeImage(Provider.of<ConnectionObject>(context)
                        .internalSocketId),
                    width: 400),
              ],
            ),
          ),
        );
      },
    ).then((value) => dialogOpen = false);
  }

  Future<void> _cameraFunc() async {
    dialogOpen = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.enterID,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                TextField(
                  controller: txtController,
                ),
                SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () => {
                          Provider.of<ConnectionObject>(context,listen:false).connectOffer(txtController.text),
                          Navigator.of(context, rootNavigator: true).pop('dialog'),
                          waitingForConnection(txtController.text)
                          //txtController.text für den InputField text
                        },
                    child: Text(AppLocalizations.of(context)!.connect))
                //CHRISTIAN hier noch qr code scanner einfügen; man kann ja beides haben ig
              ],
            ),
          ),
        );
      },
    ).then((value) => dialogOpen = false);
  }

  Future<void> waitingForConnection(String id) async {
    dialogOpen = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.connectionReq,
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 30),
                    Center(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.1,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              color: Theme.of(context)
                                  .primaryColor, //Colors.purple,
                              strokeWidth: 10,
                            ))),
                    SizedBox(height: 30),
                    Text(AppLocalizations.of(context)!.waitingOn +
                        " " +
                        id +
                        "..."),
                    SizedBox(height: 20),
                    OutlinedButton(
                        onPressed: () => {
                              print("cancel"),
                              Provider.of<ConnectionObject>(context,
                                      listen: false)
                                  .sendDisconnectRequest(
                                      "User hat die Verbindung abgebrochen!"),
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog')
                            },
                        child: Text(AppLocalizations.of(context)!.cancel)),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ));
      },
    ).then((value) => dialogOpen = false);
  }

  Future<void> _settings() async {
    dialogOpen = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.settings,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                TextButton(
                    child: Text(AppLocalizations.of(context)!.german),
                    onPressed: () {
                      MyApp.of(context)!
                          .setLocale(Locale.fromSubtags(languageCode: 'de'));
                    }),
                SizedBox(height: 10),
                TextButton(
                    child: Text(AppLocalizations.of(context)!.english),
                    onPressed: () {
                      //DeviceSelection.setLocale(context, Locale("en"));
                      MyApp.of(context)!
                          .setLocale(Locale.fromSubtags(languageCode: 'en'));
                    }),
                SizedBox(height: 10),
                TextButton(
                    child: Text("Startbildschirm nocheinmal anzeigen"),
                    onPressed: () => unsetShared()),
                SizedBox(height: 10),
                TextButton(
                  child: Text("Anleitung"),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Anleitung()));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: Text("Startscreen"),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => StartScreen()));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: Text("Connection Lost"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ConnectionLost()));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: Text("Connection Lost Popup"),
                  onPressed: () {
                    connectionLostPopup();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: Text("Neue Settings"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SettingsScreen()));
                  },
                ),
                TextButton(
                  child: Text("test"),
                  onPressed: () {
                    waitingForConnection("1234");
                  },
                ),
                TextButton(
                  child: Text("test222"),
                  onPressed: () {
                    disconnectPopup("reason");
                  },
                ),
                TextButton(
                  child: Text("test333"),
                  onPressed: () {
                    acceptRejectConnection("weezer");
                  },
                ),
                TextButton(
                  child: Text("test444"),
                  onPressed: () {
                    AdaptiveTheme.of(context).toggleThemeMode();
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) => dialogOpen = false);
  }

  Future<void> _selectTheme() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.chooseATheme,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                TextButton(
                    child: Text(AppLocalizations.of(context)!.lightTheme),
                    onPressed: () {
                      AdaptiveTheme.of(context).setLight();
                    }),
                SizedBox(height: 10),
                TextButton(
                    child: Text(AppLocalizations.of(context)!.darkTheme),
                    onPressed: () {
                      AdaptiveTheme.of(context).setDark();
                    }),
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
                title: Text(AppLocalizations.of(context)!.settings),
                onTap: () {
                  _settings();

                  //altes menü ist drinnen zum testen
                  /*Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingsScreen()));*/
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text(AppLocalizations.of(context)!.instructions),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Anleitung()));
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(AppLocalizations.of(context)!.aboutTheApp),
                onTap: () {
                  _aboutDialog();
                },
              ),
            ],
          ),
        ),
        appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Column(children: [
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 4),

              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: Colors.black, padding: EdgeInsets.all(12)),
                  onPressed: () => {print("qr button"), _qrDialog()},
                  //shape:RectangleBorder(
                  //borderRadius: BorderRadius.circular(16))),
                  child: Row(
                    children: [
                      Icon(Icons.qr_code,
                          color: Theme.of(context).textTheme.headline4!.color),
                      SizedBox(width: 10),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: AutoSizeText(
                              AppLocalizations.of(context)!.yourDevice,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              minFontSize: 0,
                              maxFontSize: 30,
                              //presetFontSizes: [30, 15, 5],
                              stepGranularity: 1,
                              style: Theme.of(context).textTheme.headline4)),
                      SizedBox(width: 10),
                      Icon(Icons.qr_code, color: Colors.transparent),
                    ],
                  )),
              // SizedBox(width: 30),
              Spacer(flex: 1),
              Container(
                child: IconButton(
                    onPressed: () => {print("camera"), _cameraFunc()},
                    // splashColor: Colors.purple,
                    constraints: BoxConstraints(
                        minHeight: 100,
                        minWidth: 100,
                        maxHeight: double.infinity,
                        maxWidth: double.infinity),
                    iconSize: 40.0,
                    icon: Icon(Icons.photo_camera)),
              ),
              Spacer(flex: 4),
              //SizedBox(width: MediaQuery.of(context).size.width * 0.2)
            ],

            //),
          ),
          //Abstand
          Spacer(flex: 1),
          AutoSizeText(AppLocalizations.of(context)!.nearbyDevices,
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        group: devicesGroup,
                                        maxFontSize: 25,
                                        stepGranularity: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              )
                            ]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChooseFiles(
                                    targetDeviceName: names[index],
                                  )));
                        }),
                  );
                },
              )),

          SizedBox(height: 20),

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
