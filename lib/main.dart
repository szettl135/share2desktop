import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:share2desktop/deviceSelection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share2desktop/startscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      if (kIsWeb) {
  
} else 
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Share2Desktop');
    setWindowMaxSize(const Size(1536, 1064));
    setWindowMinSize(const Size(1024, 776));
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale =  window.locales[0];//new Locale("de");//new Locale(Platform.localeName.substring(0,2));//getCurrentLocale();//WidgetsBinding.instance!.window.locales[0];//findSystemLocale() as Locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  bool firstStart = false;
  
  _MyAppState() {
  SharedPreferences.getInstance().then((value) => {
    firstStart=  (value.getBool('seen') ?? false)
    });
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
        locale: _locale,
        scrollBehavior: AppScrollBehavior(),
        darkTheme: darkTheme,
        home: firstStart ? DeviceSelection() : StartScreen(),
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
