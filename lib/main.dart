import 'package:flutter/material.dart';
import 'package:share2desktop/deviceSelection.dart';
import 'package:share2desktop/startpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share2Desktop',
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Color(0xffEBF7FF),
          primaryColor: Color(0xff5F79FF),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.white, //  <-- dark color
            textTheme: ButtonTextTheme.primary, //  <-- this auto selects the right color
          ),
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
            headline2: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 14.0),
          )


          ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xff252525),
          primaryColor: Color(0xff161616),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.white, 
            textTheme: ButtonTextTheme.primary, //  <-- this auto selects the right color
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
          // Define the default font family.
          fontFamily: 'Arial',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 14.0),
          )
          /* dark theme settings */
          ),
      //damit system theme verwendet wird beim straten
      themeMode: ThemeMode.system,

      home: DeviceSelection(),
    );
  }
}
