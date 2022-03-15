import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';
import 'package:share2desktop/deviceSelection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share2desktop/startscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';
import 'package:share2desktop/connectionObject.dart';
import 'package:provider/provider.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  if (kIsWeb) {
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Share2Desktop');
    setWindowMaxSize(const Size(1536, 1064));
    setWindowMinSize(const Size(1024, 776));
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => ConnectionObject(context),
      child: MyApp(),
    ),
  );
}


Future<void> disconnectPopup(BuildContext context, String reason) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.connectionLost,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                Text(reason)
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> acceptRejectConnection(BuildContext context, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
         return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.connectionReq,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                Text(AppLocalizations.of(context)!.device +
                    " " +
                    id +
                    " " +
                    AppLocalizations.of(context)!.wantsToConnect),
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  OutlinedButton(
                      onPressed: () => {
                            Provider.of<ConnectionObject>(context,listen:false).createAnswer(),
                            Navigator.of(context, rootNavigator: true).pop('dialog')
                          },
                      child: Text(AppLocalizations.of(context)!.accept)),
                      SizedBox(width: 10),
                      OutlinedButton(
                      onPressed: () => {
                            Provider.of<ConnectionObject>(context,listen:false).sendDisconnectRequest("rejection"),
                            Navigator.of(context, rootNavigator: true).pop('dialog')
                          },
                      child: Text(AppLocalizations.of(context)!.reject)),
                ])
              ],
            ),
          ),
        ));
      },
    );
  }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = window.locales[
      0]; //new Locale("de");//new Locale(Platform.localeName.substring(0,2));//getCurrentLocale();//WidgetsBinding.instance!.window.locales[0];//findSystemLocale() as Locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }


 

  bool notFirstStart = false;

  String speicherpfad = "";

  _MyAppState() {
    SharedPreferences.getInstance()
        .then((value) => {notFirstStart = (value.getBool('seen') ?? false)});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(
            color: const Color(0xff5F79FF),
          ),
          scaffoldBackgroundColor: Color(0xffEBF7FF),
          primaryColor: Color(0xff5F79FF),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.white, //  <-- dark color
            textTheme: ButtonTextTheme
                .primary, //  <-- this auto selects the right color
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            primary: Color(0xff5F79FF),
            textStyle: TextStyle(color: Colors.white),
          )),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.black, // This is a custom color variable
              //textStyle: GoogleFonts.fredokaOne(),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.black, // This is a custom color variable
              //textStyle: GoogleFonts.fredokaOne(),
            ),
          ),
          // Define the default font family.
          fontFamily: 'Arial',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 16.0),

            //Cards
            headline3: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            //Knopf1
            headline4: TextStyle(fontSize: 30.0, color: Colors.black),
            //Knopf2
            headline5: TextStyle(
                fontSize: 35.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )),
      dark: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            color: const Color(0xff161616),
          ),
          scaffoldBackgroundColor: Color(0xff252525),
          primaryColor: Color(0xff161616),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.white,
            textTheme: ButtonTextTheme
                .primary, //  <-- this auto selects the right color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            primary: Color(0xff161616),
            textStyle: TextStyle(color: Colors.white),
          )),
          // Define the default font family.
          fontFamily: 'Arial',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 16.0),

            //Cards
            headline3: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            //Knopf1
            headline4: TextStyle(fontSize: 30.0, color: Colors.white),
            //Knopf2
            headline5: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )
          /* dark theme settings */
          ),
      //damit system theme verwendet wird beim straten

      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Share2Desktop',
        theme: theme,
        debugShowCheckedModeBanner: false,
        locale: _locale,
        scrollBehavior: AppScrollBehavior(),
        darkTheme: darkTheme,
        home: notFirstStart ? DeviceSelection() : StartScreen(),
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
