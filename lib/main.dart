import 'package:adaptive_theme/adaptive_theme.dart';
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
            textTheme: ButtonTextTheme.primary, //  <-- this auto selects the right color
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(  
          style: ElevatedButton.styleFrom(
            
            primary: Color(0xff5F79FF),
            textStyle:TextStyle(color: Colors.white),

          )
        
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
            headline2: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 16.0),

            //Cards
            headline3: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
            //Knopf1
            headline4: TextStyle(fontSize: 30.0, color: Colors.black),
            //Knopf2
            headline5: TextStyle(fontSize: 35.0, color: Colors.black, fontWeight: FontWeight.bold),
          )


          ),
      dark: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            color: const Color(0xff161616),
          ),
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

           elevatedButtonTheme: ElevatedButtonThemeData(  
          style: ElevatedButton.styleFrom(
            
            primary: Color(0xff161616),
            textStyle: TextStyle(color: Colors.white),

          )
        
          ),
          // Define the default font family.
          fontFamily: 'Arial',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 16.0),

            //Cards
            headline3: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            //Knopf1
            headline4: TextStyle(fontSize: 30.0),
            //Knopf2
            headline5: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
          )
          /* dark theme settings */
          ),
      //damit system theme verwendet wird beim straten
      
      initial: AdaptiveThemeMode.system,
       builder: (theme, darkTheme) => MaterialApp(
        title: 'Share2Desktop',
        theme: theme,
        darkTheme: darkTheme,
        home: DeviceSelection(),
      ),
    );
  }
}
